class VisitorsController < ApplicationController
  def landing
    @performers = Offering.approved.limit(12)
    @brands = Brand.limit(3)
    @totals = {}
    Purchase.all.each do |p|
      @totals[p.price_json['currency']] ||= 0
      @totals[p.price_json['currency']] += p.price_json['take']
    end
  end

end
