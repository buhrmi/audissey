# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  offering_id          :integer
#  user_id              :integer
#  start_at             :datetime
#  end_at               :datetime
#  offerer_confirmed_at :datetime
#  buyer_confirmed_at   :datetime
#  note                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  price_id             :integer
#

class Booking < ActiveRecord::Base
  has_many :messages, :as => 'topicable'
  belongs_to :offering
  belongs_to :user
  belongs_to :price
  accepts_nested_attributes_for :price

  has_one :purchase, :as => 'buyable'

  def payment_received?
    purchase.present?
  end

  def editable_by?(user)
    self.user_id == user.id || self.offering.user_id == user.id
  end
end
