class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @show_guide = true
    @show_guide = false if current_user.artists.any?
    @show_guide = false if current_user.bookings.any?

    

  end
  
  def profile
    render :show
  end
  
  def account
    render :show
  end
  
  def bookings
    bookings_from_me = current_user.bookings
    bookings_with_me = Booking.where(:artist => current_user.artists)
    @all_bookings = (bookings_from_me + bookings_with_me).uniq
    render :show
  end
  
end
