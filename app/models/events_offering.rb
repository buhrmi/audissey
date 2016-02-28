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

class EventsOffering < ActiveRecord::Base
end
