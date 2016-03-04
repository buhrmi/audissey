# == Schema Information
#
# Table name: purchases
#
#  id                   :integer          not null, primary key
#  buyable_id           :integer
#  buyable_type         :string
#  price_json           :string
#  buyer_id             :integer
#  gateway_id           :string
#  gateway_tx_id        :string
#  gateway_user_id      :string
#  gateway_confirmed_at :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  beneficiary_id       :integer
#  memo                 :string
#  value_date           :datetime
#  commission_percent   :integer
#

class PurchasesController < ApplicationController
  # before_filter :authenticate_user!

  def new

  end


  # TODO: Use CREDIT CHANGES if purchased an offering via fixed pricing:
  # 1. Create credit change +1 for offering (source: this purchase)
  # 2. If booking given, use credit to pay for the booking via -1 credit change (source: booking)
  def create
    if !current_user && params[:email]
      return redirect_to(new_session_path, :notice => 'Please log in first') if User.where(:email => params[:email]).any?
      generated_password = Devise.friendly_token.first(8)
      user = User.create :email => params[:email], :password => generated_password
      sign_in(user)
    end
    
    if params[:price_id]
      price = Price.find(params[:price_id])
    elsif params[:offering_id]
      offering = Offering.find(params[:offering_id])
      return cancel unless offering.availability == 'instant'
      amount = params[:amount]
      currency = params[:currency]
      price = Price.create :take => amount, :currency => currency
      buyable = Booking.new :price => price, 
        :offering => offering, :user => current_user,
        :start_at => params[:date], :offerer_confirmed_at => Time.now,
        :buyer_confirmed_at => Time.now
    end
    
    

    
    
    buyable ||= price.buyable || Booking.find_by_price_id(price.id)
    

    # right now we assume buyable is a booking.... but could be anything actually.
    description = "audissey.fm booking #{buyable.id} (#{buyable.offering.actionable_name})"
    return unless current_user.can_purchase?(buyable)

    if params[:gateway] == 'webpay'
      webpay = WebPay.new(ENV['WEBPAY_SECRET_KEY'])
      charge_response = webpay.charge.create(
        amount: price.take,
        currency: price.currency.downcase,
        card: params['webpay-token'],
        description: description
      )
      paid = charge_response.paid
      error = charge_response.failure_message
      txid = charge_response.id
    end

    if params[:gateway] == 'stripe'
      begin
        charge = Stripe::Charge.create(
          :amount => price.take, # amount in cents, again
          :currency => price.currency.downcase,
          :source => params[:stripeToken],
          :description => description
        )
        paid = true
        txid = charge.id
      rescue Stripe::CardError => e
        error = e
      end
    end



    if paid
      buyable.save!
      if buyable.is_a?(Booking)
        beneficiary = buyable.offering.user
        memo = buyable.offering.actionable_name
        value_date = buyable.start_at + 1.days
        commission_percent = buyable.offering.commission_percent
      end
      Purchase.create :buyer => current_user,
        :buyable => buyable,
        :price_json => price,
        :gateway_id => params[:gateway], 
        :gateway_tx_id => txid,
        :beneficiary => beneficiary,
        :memo => memo,
        :value_date => value_date,
        :commission_percent => commission_percent
      if buyable.is_a?(Booking)
        UserNotifier.booking_payment_received(buyable).deliver_later if buyable.offering.user
        UserNotifier.booking_payment_received_for_management(buyable).deliver_later if buyable.offering.managed
        UserNotifier.booking_payment_completed(buyable).deliver_later
        Message.create(:topicable => buyable, :text => 'Payment has been received.') 
      end
      if generated_password
        #UserNotifier.welcome_with_password(current_user, generated_password).deliver_later
      end
      
      redirect_to buyable
    else
      flash[:error] = error
      redirect_to :back
    end
  end
end
