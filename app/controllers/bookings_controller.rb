# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  artist_id          :integer
#  user_id              :integer
#  start_at             :datetime
#  end_at               :datetime
#  artist_confirmed_at :datetime
#  buyer_confirmed_at   :datetime
#  note                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  price_id             :integer
#  location_id          :integer
#  deleted_at           :datetime
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
  def show
    return redirect_to new_user_registration_path unless current_user
    return cancel 'Not authorized' unless @booking.editable_by?(current_user)
  end

  # GET /bookings/new
  def new
    @artist = Artist.find(params[:artist])
    @booking = @artist.bookings.new(:user => current_user)
  end

  # GET /bookings/1/edit
  def edit
    return false unless @booking.editable_by?(current_user)
  end

  # POST /bookings
  # POST /bookings.json
  def create
    return redirect_to new_user_session_path unless current_user
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
    @booking.buyer_confirmed_at = Time.now
    cancel "You can't book yourself" and return if @booking.artist.user_id == current_user.id && !current_user.superpowers?
    return false unless @booking.editable_by?(current_user)
    respond_to do |format|
      if @booking.save
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
    return false unless @booking.editable_by?(current_user)
    updates = booking_update_params
    if params[:confirm] && @booking.artist.user_id == current_user.id
      updates[:artist_confirmed_at] = Time.now
      confirmed = true
    end
    respond_to do |format|
      if @booking.update(updates)
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
    return cancel unless @booking.editable_by?(current_user)
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
      params[:booking].permit(:artist_id, :start_at, :price_attributes => [:id, :take, :currency])
    end
end
