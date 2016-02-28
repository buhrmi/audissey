class VisitorsController < ApplicationController
  def landing
    @performers = Offering.approved.limit(12)
    @brands = Brand.limit(3)
  end

end
