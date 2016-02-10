class DashboardsController < ApplicationController
  def show
    @show_guide = true
    @show_guide = false if current_user.offerings.any?
    @show_guide = false if current_user.bookings.any?

    
    @purchased_bookings = Booking.joins(:purchase).where(:offering => current_user.offerings).order('created_at DESC')
    bookings_from_me = current_user.bookings
    bookings_with_me = Booking.where(:offering => current_user.offerings)
    @all_bookings = (bookings_from_me + bookings_with_me).uniq

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
