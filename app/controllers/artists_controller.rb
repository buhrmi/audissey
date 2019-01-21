# == Schema Information
#
# Table name: artists
#
#  id                    :integer          not null, primary key
#  name       :string
#  description           :text
#  user_id               :integer
#  image_uid             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category_id           :string
#  duration              :integer
#  published_at          :datetime
#  approved_at           :datetime
#  approved_by_id        :integer
#  hero_image_uid        :string
#  contact_details          :text
#  commission_percent    :integer          default(15)
#  address               :string
#  latitude              :float
#  longitude             :float
#  deleted_at            :datetime
#  management_name       :string
#  management_email      :string
#  management_image_uid  :string
#  managed               :boolean
#  image_name            :string
#  management_image_name :string
#  promo_video_url       :string
#  url_fragment          :string
#  logo_image_uid        :string
#  logo_image_name       :string
#

class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]


  # GET /artists/1
  # GET /artists/1.json
  def show
    @graph_object = @artist
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
    cancel and return unless @artist.editable_by?(current_user)
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)
    @artist.user_id = current_user.id
    @artist.approved_at = Time.now
        
    respond_to do |format|
      if @artist.save
        UserNotifier.admin_new_listing(@artist).deliver_later
        format.html { redirect_to edit_artist_path(@artist, :section => 'description'), notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    return unless @artist.editable_by?(current_user)
    updates = artist_params
    if params[:artist][:disconnect]
      if @artist.pending_bookings.any?
        return redirect_to :back, :notice => 'There are pending bookings. Cant disconnect.'
      else
        updates[:user_id] = nil
      end
    end
    if params[:artist][:approve] && current_user.superpowers? && !@artist.approved_at
      updates[:approved_by] = current_user
      updates[:approved_at] = Time.now
    end
    respond_to do |format|
      if @artist.update(updates)
        format.html { redirect_to nice_artist_url(@artist.url_fragment), notice: @artist.name + ' was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    cancel and return unless @artist.editable_by?(current_user)
    cancel t('.in_use') and return if @artist.pending_bookings.any?
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      if params[:id]
        @artist = Artist.find(params[:id])
      elsif params[:artist_name]
        @artist = Artist.find_by_url_fragment(params[:artist_name])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:retained_image, :availability,
      :contact_details, :category_id, :name, :managed, :promo_video_url,
      :en_description, :ja_description, :management_name, :retained_management_image, :management_email,
      :prices_attributes => [:id, :_destroy, :take, :give, :currency])
    end
end
