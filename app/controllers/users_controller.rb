# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  provider               :string
#  uid                    :string
#  superpowers            :boolean
#  image_uid              :string
#  locale                 :string
#  tz                     :string
#  currency               :string
#  deleted_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  image_name             :string
#

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # unless @user == current_user
    #   redirect_to :back, :alert => "Access denied."
    # end
  end

  def destroy
    @user = User.find(params[:id])
    cancel t(".in_use") and return if @user.artists.any? { |o| o.pending_bookings.any? }
    @user.artists.map(&:destroy)
    cancel and return unless @user.id == current_user.id
    @user.update :email => @user.email + '_' + SecureRandom.hex 
    @user.destroy
    redirect_to root_url, :notice => t('.destroyed')
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to :back, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def user_params
    params[:user].permit(:retained_image, :name, :email)
  end
end
