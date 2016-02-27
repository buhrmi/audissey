class EventsController < InheritedResources::Base

  private

    def event_params
      params.require(:event).permit(:brand_id, :venue_id, :flyer_image_uid, :flyer_image_name, :name, :start_at, :end_at)
    end
end

