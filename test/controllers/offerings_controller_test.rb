# == Schema Information
#
# Table name: offerings
#
#  id              :integer          not null, primary key
#  actionable_name :string
#  description     :text
#  user_id         :integer
#  image_uid       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :string
#  duration        :integer
#  published_at    :datetime
#  approved_at     :datetime
#  approved_by_id  :integer
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
