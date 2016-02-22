# == Schema Information
#
# Table name: uploads
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  file_name       :string
#  file_uid        :string
#  mime_type       :string
#  through         :string
#  bytes           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_id   :integer
#  attachable_type :string
#

class Upload < ActiveRecord::Base
  acts_as_list
  
  scope :images, lambda { where("mime_type LIKE 'image%'") }
  scope :not_images, lambda { where("mime_type NOT LIKE 'image%'") }
  belongs_to :user
  belongs_to :attachable, :polymorphic => true
  dragonfly_accessor :file
end
