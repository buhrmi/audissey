class DashboardsController < ApplicationController
  def show
    @purchased_bookings = Booking.joins(:purchase).where(:offering => current_user.offerings).order('created_at DESC')

    # To arrive at current account balance, sum up all bookings since last requested payout
    @balances = {}
    @purchased_bookings.each do |booking|
      currency = booking.purchase.price_json['currency']
      amount   = booking.purchase.price_json['take']
      @balances[currency] ||= 0
      @balances[currency] += amount
    end
  end
end
