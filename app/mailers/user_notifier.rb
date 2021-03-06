class UserNotifier < ApplicationMailer
  default :from => 'Audissey <team@audissey.fm>'

  def booking_inquiry(booking)
    @booking = booking
    @artist = booking.artist
    @user = booking.artist.user
    mail :to => @user.email, :subject => "Booking Request for #{@artist.name}"
  end
  
  def booking_inquiry_for_management(booking)
    @booking = booking
    @artist = booking.artist
    @user = @artist.management_user
    mail :to => @user.email, :subject => "Booking Request for #{@artist.name}"
  end

  def booking_confirmed(booking)
    @booking = booking
    @artist = booking.artist
    @user = booking.user
    mail :to => @user.email, :subject => "#{@artist.name} confirmed your booking!"
  end

  def booking_payment_received(booking)
    @booking = booking
    @artist = booking.artist
    @user = booking.artist.user
    mail :to => @user.email, :subject => "Payment for #{@artist.name} received"
  end
  
  def booking_payment_received_for_management(booking)
    @booking = booking
    @artist = booking.artist
    @user = booking.artist.management_user
    mail :to => @user.email, :subject => "Payment for #{@artist.name} received"
  end

  def booking_payment_completed(booking)
    @booking = booking
    @artist = booking.artist
    @user = booking.user
    mail :to => @user.email, :subject => "Payment confirmation and further information"
  end
  
  def admin_new_listing(artist)  
    @artist = artist
    return unless Rails.env.production?
    mail :to => 'XXXX@ringmasters.cc', :subject => "Please approve: #{artist.name}"
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
      :from => "#{message.sender.display_name} on Audissey <team@audissey.fm>",
      :subject => "#{message.topicable.topicable_name}",
      :reply_to => "#{message.sender.display_name} <#{reply_to}>"
  end
end
