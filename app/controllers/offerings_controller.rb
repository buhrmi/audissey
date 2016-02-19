# == Schema Information
#
# Table name: offerings
#
#  id                 :integer          not null, primary key
#  actionable_name    :string
#  description        :text
#  user_id            :integer
#  image_uid          :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category_id        :string
#  duration           :integer
#  published_at       :datetime
#  approved_at        :datetime
#  approved_by_id     :integer
#  hero_image_uid     :string
#  escrow_notes       :text
#  commission_percent :integer          default(15)
#  address            :string
#  latitude           :float
#  longitude          :float
#  deleted_at         :datetime
#

class OfferingsController < ApplicationController
  before_action :set_offering, only: [:show, :edit, :update, :destroy]


  # GET /offerings/1
  # GET /offerings/1.json
  def show
    cancel and return unless @offering.editable_by?(current_user)
  end

  # GET /offerings/new
  def new
    @offering = Offering.new
  end

  # GET /offerings/1/edit
  def edit
    cancel and return unless @offering.editable_by?(current_user)
  end

  # POST /offerings
  # POST /offerings.json
  def create
    @offering = Offering.new(offering_params)
    @offering.user_id = current_user.id
        
    respond_to do |format|
      if @offering.save
        UserNotifier.admin_new_listing(@offering).deliver_later
        format.html { redirect_to edit_offering_path(@offering, :section => 'description'), notice: 'Offering was successfully created.' }
        format.json { render :show, status: :created, location: @offering }
      else
        format.html { render :new }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offerings/1
  # PATCH/PUT /offerings/1.json
  def update
    return unless @offering.editable_by?(current_user)
    updates = offering_params
    if params[:offering][:disconnect]
      if @offering.pending_bookings.any?
        return redirect_to :back, :notice => 'There are pending bookings. Cant disconnect.'
      else
        updates[:user_id] = nil
      end
    end
    if params[:offering][:approve] && current_user.superpowers? && !@offering.approved_at
      updates[:approved_by] = current_user
      updates[:approved_at] = Time.now
    end
    respond_to do |format|
      if @offering.update(updates)
        format.html { redirect_to @offering, notice: @offering.actionable_name + ' was successfully updated.' }
        format.json { render :show, status: :ok, location: @offering }
      else
        format.html { render :edit }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offerings/1
  # DELETE /offerings/1.json
  def destroy
    cancel and return unless @offering.editable_by?(current_user)
    cancel t('.in_use') and return if @offering.pending_bookings.any?
    @offering.destroy
    respond_to do |format|
      format.html { redirect_to offerings_url, notice: 'Offering was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offering
      @offering = Offering.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offering_params
      params.require(:offering).permit(:retained_image, 
      :escrow_notes, :category_id, :actionable_name, :managed,
      :description, :management_name, :retained_management_image, :management_email,
      :prices_attributes => [:id, :_destroy, :take, :give, :currency])
    end
end
