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

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
