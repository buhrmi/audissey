class UserNotifier < ApplicationMailer
  default :from => 'Audissey <team@audissey.fm>'

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
  
  def message_received(message, to_user)
    @message = message
    @booking = @message.topicable if @message.topicable_type == 'Booking'
    embed_data = {
      :sender_id => to_user.id,
      :topicable_id => message.topicable_id,
      :topicable_type => message.topicable_type
    }
    crypt = ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'])
    encrypted = crypt.encrypt_and_sign(embed_data.to_json)
    reply_to = "reply+#{encrypted}@relay.audissey.fm"
    mail :to => to_user.email,
      :from => '#{message.sender.display_name} | Audissey <team@audissey.fm>',
      :subject => "Message on Audissey regarding #{message.topicable.topicable_name}",
      :reply_to => "#{message.sender.display_name} <#{reply_to}>"
  end
end
