class VisitorsController < ApplicationController
  def landing
    @performers = Offering.approved.limit(6)
  end

end
