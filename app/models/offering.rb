# == Schema Information
#
# Table name: offerings
#
#  id                    :integer          not null, primary key
#  actionable_name       :string
#  description           :text
#  user_id               :integer
#  image_uid             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category_id           :string
#  duration              :integer
#  published_at          :datetime
#  approved_at           :datetime
#  approved_by_id        :integer
#  hero_image_uid        :string
#  escrow_notes          :text
#  commission_percent    :integer          default(15)
#  address               :string
#  latitude              :float
#  longitude             :float
#  deleted_at            :datetime
#  management_name       :string
#  management_email      :string
#  management_image_uid  :string
#  managed               :boolean
#  image_name            :string
#  management_image_name :string
#  promo_video_url       :string
#

# Use Case: Buy 4 offerings for 5 USD
# 1. Create price (4 for 5 USD)
# 2. Create purchase using that price
# 3. Through purchase, give user 4 credits for this offering
# 4. Use credits to create booking
# 5. Both parties (booker and offering creator) need to confirm booking (contract signing). Can change time.
# 6. Can cancel booking any time
# 7. After booking, release money to offerer

class Offering < ActiveRecord::Base
  include Buyable
  include Translatable

  acts_as_paranoid

  belongs_to :user
  belongs_to :approved_by, :class_name => 'User'
  belongs_to :category
  has_many :availability_rules
  has_many :bookings
  has_many :uploads, :as => 'attachable'

  scope :approved, lambda { where('approved_at IS NOT NULL') }

  dragonfly_accessor :image
  dragonfly_accessor :hero_image
  dragonfly_accessor :management_image
  accepts_nested_attributes_for :prices, :allow_destroy => true
  accepts_translations_for :description

  before_update do
    self.url_fragment = actionable_name.gsub(/[^0-9A-Za-z]/,'').underscore
  end
    

  def availability_on(day)

  end

  def earliest_availability()

  end
  
  def pending_bookings
    bookings.where(['start_at > ?', Time.current])
  end

  def editable_by?(user)
    return false unless user
    user&.superpowers? or self.user_id == user&.id
  end
  
  def to_s
    actionable_name
  end
  
  def profile_image
    management_image || user&.image
  end
  
  def set_user_by_management_email
    return unless management_email
    u = User.find_by_email(management_email)
    update :user => u if u
  end
  
  def bookable?
    emails.any?
  end
  
  def emails
    [user&.email, management_email].compact
  end
  
  def management_user
    User.new(:name => management_name, :email => management_email, :image_uid => management_image_uid)
  end
  
  def public_images
    uploads.images.free
  end
  
  def iframe_video_url
    youtube_id = promo_video_url.match(/v=(.*)/)[1] rescue nil
    if youtube_id
      "http://www.youtube.com/embed/#{youtube_id}?autoplay=1&modestbranding=1&showinfo=0"
    end
  end
  
  def name
    actionable_name
  end
  
  

end
