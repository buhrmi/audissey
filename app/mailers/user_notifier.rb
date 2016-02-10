class UserNotifier < ApplicationMailer
  default :from => 'Audissey Team <team@audissey.fm>'

  def booking_inquiry(booking)
    @booking = booking
    @offering = booking.offering
    @user = booking.offering.user
    mail :to => @user.email, :subject => "Booking Request for #{@offering.actionable_name}"
  end

  def booking_confirmed(booking)
    @booking = booking
    @offering = booking.offering
    @user = booking.user
    mail :to => @user.email, :subject => "#{@offering.actionable_name} confirmed your booking!"
  end

  def booking_payment_received(booking)
    @booking = booking
    @offering = booking.offering
    @user = booking.offering.user
    mail :to => @user.email, :subject => "Payment for #{@offering.actionable_name} received"
  end

  def booking_payment_completed(booking)
    @booking = booking
    @offering = booking.offering
    @user = booking.user
    mail :to => @user.email, :subject => "Payment confirmation and further information"
  end
  
  def admin_new_listing(offering)  
    @offering = offering
    return unless Rails.env.production?
    mail :to => 'gee.daigo@ringmasters.cc', :subject => "Please approve: #{offering.actionable_name}"
  end
end
