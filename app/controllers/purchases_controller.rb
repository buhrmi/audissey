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

  def create
    create_webpay if params[:gateway] == 'webpay'
    create_stripe if params[:gateway] == 'stripe'
  end


  def create_stripe
    # TODO
  end

  # TODO: Use CREDIT CHANGES if purchased an offering via fixed pricing:
  # 1. Create credit change +1 for offering (source: this purchase)
  # 2. If booking given, use credit to pay for the booking via -1 credit change (source: booking)
  def create_webpay

    price = Price.find(params[:price_id])

    buyable = price.buyable
    if !buyable
      buyable = Booking.find_by_price_id(price.id)
    end

    description = url_for(buyable) + ' / Price ID: ' + price.id.to_s
    return unless current_user.can_purchase?(buyable)

    webpay = WebPay.new(ENV['WEBPAY_SECRET_KEY'])
    charge_response = webpay.charge.create amount: price.take,
      currency: price.currency.downcase,
      card: params['webpay-token'],
      description: description

    if charge_response.paid
      Purchase.create :buyer => current_user, :buyable => buyable, :price_json => price, :gateway_id => 'webpay.jp', :gateway_tx_id => charge_response.id
      UserNotifier.booking_payment_received(buyable).deliver_later if buyable.is_a?(Booking)
      UserNotifier.booking_payment_completed(buyable).deliver_later if buyable.is_a?(Booking)
      redirect_to :back
    else
      flash[:error] = charge_response.failure_message
      redirect_to :back
    end
  end
end
