# == Schema Information
#
# Table name: events_offerings
#
#  id          :integer          not null, primary key
#  event_id    :integer
#  offering_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EventsOfferingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
