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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end