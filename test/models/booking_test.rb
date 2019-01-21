# == Schema Information
#
# Table name: bookings
#
#  id                   :integer          not null, primary key
#  offering_id          :integer
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

require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
