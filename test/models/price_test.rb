# == Schema Information
#
# Table name: prices
#
#  id           :integer          not null, primary key
#  give         :integer          default(1)
#  take         :integer
#  currency     :string
#  buyable_id   :integer
#  buyable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class PriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
