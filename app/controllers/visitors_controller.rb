class VisitorsController < ApplicationController
  def landing
    @performers = Offering.where(:category_id => 'performer').limit(6)
  end

end
