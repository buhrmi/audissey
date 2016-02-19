class VisitorsController < ApplicationController
  def landing
    @performers = Offering.approved.limit(12)
  end

end
