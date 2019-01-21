# == Schema Information
#
# Table name: credit_changes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  artist_id :integer
#  delta       :integer
#  source_id   :integer
#  source_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CreditChangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
