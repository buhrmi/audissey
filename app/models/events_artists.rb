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

class EventsArtist < ActiveRecord::Base
end
