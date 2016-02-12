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
#

class PurchasesController < ApplicationController
  # before_filter :authenticate_user!

  def new

  end


  # TODO: Use CREDIT CHANGES if purchased an offering via fixed pricing:
  # 1. Create credit change +1 for offering (source: this purchase)
  # 2. If booking given, use credit to pay for the booking via -1 credit change (source: booking)
  def create
    price = Price.find(params[:price_id])

    buyable = price.buyable
    if !buyable
      buyable = Booking.find_by_price_id(price.id)
    end

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
      Purchase.create :buyer => current_user, :buyable => buyable, :price_json => price, :gateway_id => params[:gateway], :gateway_tx_id => txid
      if buyable.is_a?(Booking)
        UserNotifier.booking_payment_received(buyable).deliver_later
        UserNotifier.booking_payment_completed(buyable).deliver_later
        Message.create(:topicable => buyable, :text => 'Payment has been received.') 
      end
      redirect_to :back
    else
      flash[:error] = error
      redirect_to :back
    end
  end
end
