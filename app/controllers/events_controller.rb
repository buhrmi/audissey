# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  brand_id         :integer
#  venue_id         :integer
#  flyer_image_uid  :string
#  flyer_image_name :string
#  name             :string
#  start_at         :datetime
#  end_at           :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class EventsController < InheritedResources::Base

  private

    def event_params
      params.require(:event).permit(:brand_id, :venue_id, :flyer_image_uid, :flyer_image_name, :name, :start_at, :end_at)
    end
end

