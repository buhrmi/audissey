# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  brand_id         :integer
#  venue_id         :integer
#  flyer_image_uid  :string
#  flyer_image_name :string
#  name             :string
#  start_at         :datetime
#  end_at           :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { brand_id: @event.brand_id, end_at: @event.end_at, flyer_image_name: @event.flyer_image_name, flyer_image_uid: @event.flyer_image_uid, name: @event.name, start_at: @event.start_at, venue_id: @event.venue_id }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { brand_id: @event.brand_id, end_at: @event.end_at, flyer_image_name: @event.flyer_image_name, flyer_image_uid: @event.flyer_image_uid, name: @event.name, start_at: @event.start_at, venue_id: @event.venue_id }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
