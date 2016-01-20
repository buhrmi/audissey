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

class Upload < ActiveRecord::Base
  scope :images, lambda { where("mime_type LIKE 'image%'") }
  scope :not_images, lambda { where("mime_type NOT LIKE 'image%'") }
  belongs_to :user
  dragonfly_accessor :file
end
