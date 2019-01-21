# == Schema Information
#
# Table name: events_artists
#
#  id          :integer          not null, primary key
#  event_id    :integer
#  artist_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EventsArtistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
