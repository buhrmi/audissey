# == Schema Information
#
# Table name: offerings
#
#  id                    :integer          not null, primary key
#  actionable_name       :string
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
#  escrow_notes          :text
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
#

require 'test_helper'

class OfferingsControllerTest < ActionController::TestCase
  setup do
    @offering = offerings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offerings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offering" do
    assert_difference('Offering.count') do
      post :create, offering: {  }
    end

    assert_redirected_to offering_path(assigns(:offering))
  end

  test "should show offering" do
    get :show, id: @offering
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offering
    assert_response :success
  end

  test "should update offering" do
    patch :update, id: @offering, offering: {  }
    assert_redirected_to offering_path(assigns(:offering))
  end

  test "should destroy offering" do
    assert_difference('Offering.count', -1) do
      delete :destroy, id: @offering
    end

    assert_redirected_to offerings_path
  end
end
