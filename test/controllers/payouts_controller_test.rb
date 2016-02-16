# == Schema Information
#
# Table name: payouts
#
#  id            :integer          not null, primary key
#  method        :string
#  method_detail :string
#  user_id       :integer
#  completed_at  :datetime
#  completed_by  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class PayoutsControllerTest < ActionController::TestCase
  setup do
    @payout = payouts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payout" do
    assert_difference('Payout.count') do
      post :create, payout: { completed_at: @payout.completed_at, completed_by: @payout.completed_by, method: @payout.method, method_detail: @payout.method_detail, user_id: @payout.user_id }
    end

    assert_redirected_to payout_path(assigns(:payout))
  end

  test "should show payout" do
    get :show, id: @payout
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payout
    assert_response :success
  end

  test "should update payout" do
    patch :update, id: @payout, payout: { completed_at: @payout.completed_at, completed_by: @payout.completed_by, method: @payout.method, method_detail: @payout.method_detail, user_id: @payout.user_id }
    assert_redirected_to payout_path(assigns(:payout))
  end

  test "should destroy payout" do
    assert_difference('Payout.count', -1) do
      delete :destroy, id: @payout
    end

    assert_redirected_to payouts_path
  end
end
