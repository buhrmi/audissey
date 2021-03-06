# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  artist_id          :integer
#  user_id              :integer
#  start_at             :datetime
#  end_at               :datetime
#  artist_confirmed_at :datetime
#  buyer_confirmed_at   :datetime
#  note                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  price_id             :integer
#  location_id          :integer
#  deleted_at           :datetime
#

class Booking < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :artist
  belongs_to :location, :class_name => 'Artist'
  belongs_to :user
  belongs_to :price
  has_many :messages, :as => 'topicable'
  has_one :purchase, :as => 'buyable'
  accepts_nested_attributes_for :price

  after_create do
    UserNotifier.booking_inquiry(self).deliver_later if artist.user
    UserNotifier.booking_inquiry_for_management(self).deliver_later if artist.managed
    Message.create(:topicable => self, :text => 'Booking request has been received.')
  end
  
  after_update do
    if artist_confirmed_at && !artist_confirmed_at_was
      UserNotifier.booking_confirmed(self).deliver_later
      Message.create(:topicable => self, :text => 'Booking has been confirmed. Awaiting payment.')
    end
  end

  def payment_received?
    purchase.present?
  end

  def editable_by?(user)
    user && (self.user_id == user.id || self.artist.user_id == user.id || user.email == self.artist.management_email)
  end
  
  def topicable_name
    artist.name
  end
  
  def to_s
    artist.name + ' booked by ' + user.display_name
  end
end
