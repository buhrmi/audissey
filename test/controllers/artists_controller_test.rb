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

require 'test_helper'

class ArtistsControllerTest < ActionController::TestCase
  setup do
    @artist = artists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:artists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create artist" do
    assert_difference('Artist.count') do
      post :create, artist: {  }
    end

    assert_redirected_to artist_path(assigns(:artist))
  end

  test "should show artist" do
    get :show, id: @artist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @artist
    assert_response :success
  end

  test "should update artist" do
    patch :update, id: @artist, artist: {  }
    assert_redirected_to artist_path(assigns(:artist))
  end

  test "should destroy artist" do
    assert_difference('Artist.count', -1) do
      delete :destroy, id: @artist
    end

    assert_redirected_to artists_path
  end
end
