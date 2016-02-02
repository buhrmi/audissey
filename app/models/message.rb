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
end
