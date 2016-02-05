class VisitorsController < ApplicationController
  def landing
    @performers = Offering.approved.where(:category_id => 'performer').limit(6)
  end

end
