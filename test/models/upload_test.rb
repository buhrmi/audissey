# == Schema Information
#
# Table name: uploads
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  file_name  :string
#  file_uid   :string
#  mime_type  :string
#  through    :string
#  bytes      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UploadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
