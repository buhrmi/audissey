# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  provider               :string
#  uid                    :string
#  superpowers            :boolean
#  image_uid              :string
#  locale                 :string
#  tz                     :string
#  currency               :string
#  deleted_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  image_name             :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,  :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauth_providers => [:facebook], :password_length => 4..127

  acts_as_paranoid

  dragonfly_accessor :image

  has_many :bookings, :dependent => :destroy
  has_many :offerings, :dependent => :destroy
  has_many :uploads, :dependent => :destroy
  has_many :purchases
  has_many :beneficiary_purchases, :class_name => 'Purchase', :foreign_key => 'beneficiary_id'
  has_many :payouts
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image_url = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def purchases_since_last_payout(at = Time.current)
    last_payout = self.payouts.where(['created_at < ?', at]).order('created_at desc').first
    if last_payout
      self.beneficiary_purchases.where(['value_date > ? AND value_date < ?', last_payout.created_at, at])
    else
      self.beneficiary_purchases.where(['value_date < ?', at])
    end
  end

  def earnings_since_last_payout(at = Time.current)
    new_purchases = purchases_since_last_payout(at)
    
    {}.tap do |earnings|
      new_purchases.each do |p|
        currency = p.price_json['currency']
        amount   = p.price_json['take']
        earnings[currency] ||= {:amount => 0, :commission => 0, :payout => 0}
        earnings[currency][:amount]     += amount
        earnings[currency][:commission] += (amount * p.commission_percent / 100).round
        earnings[currency][:payout]     += amount - (amount * p.commission_percent / 100).round
      end
    end
  end
  
  def display_name
    name || email.gsub(/@.*/, '')
  end

  def can_purchase?(buyable)
    true
  end
  
  def pending_bookings
    bookings_from_me = bookings
    bookings_with_me = Booking.where(:offering => offerings)
    (bookings_from_me + bookings_with_me).uniq
  end
end
