class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @show_guide = true
    @show_guide = false if current_user.offerings.any?
    @show_guide = false if current_user.bookings.any?

    
    bookings_from_me = current_user.bookings
    bookings_with_me = Booking.where(:offering => current_user.offerings)
    @all_bookings = (bookings_from_me + bookings_with_me).uniq

  end
end
