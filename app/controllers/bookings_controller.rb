# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  offering_id          :integer
#  user_id              :integer
#  start_at             :datetime
#  end_at               :datetime
#  offerer_confirmed_at :datetime
#  buyer_confirmed_at   :datetime
#  note                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  price_id             :integer
#

class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  # TODO: this is more like messaging view. maybe move into a messages controller
  def show
  end

  # GET /bookings/new
  def new
    @offering = Offering.find(params[:offering])
    @booking = @offering.bookings.new(:user => current_user)
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.buyer_confirmed_at = Time.now

    respond_to do |format|
      if @booking.save
        UserNotifier.booking_inquiry(@booking).deliver_later
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    updates = booking_update_params
    if params[:confirm] && @booking.offering.user_id == current_user.id
      updates[:offerer_confirmed_at] = Time.now
      confirmed = true
    end
    respond_to do |format|
      if @booking.update(updates)
        UserNotifier.booking_confirmed(@booking).deliver_later if confirmed
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end


    def booking_update_params
      return {} unless params[:booking]
      params[:booking].permit(:start_at)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params[:booking].permit(:offering_id, :start_at, :price_attributes => [:id, :take, :currency])
    end
end
