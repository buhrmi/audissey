# == Schema Information
#
# Table name: messages
#
#  id             :integer          not null, primary key
#  topicable_id   :integer
#  topicable_type :string
#  sender_id      :integer
#  text           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :topicable, :polymorphic => true
  belongs_to :sender, :class_name => 'User'
  validate :sender_matches_topicable
  
  def sender_matches_topicable
    return true unless sender_id
    if topicable_type == 'Booking'
      return true if topicable.user_id == sender.id
      return true if topicable.artist.user_id == sender.id
      errors.add :sender, 'invalid'
    end
  end
  
  after_create do
    if self.sender_id
      receivers.each do |receiver|
        UserNotifier.message_received(self, receiver).deliver_later
      end
    end
  end
  
  def receivers
    if topicable_type == 'Booking'
      if topicable.user_id == sender_id
        [topicable.artist.user]
      else
        [topicable.user]
      end
    end
  end
  
end
