# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_uid  :string
#  image_name :string
#

class Brand < ActiveRecord::Base
  include Translatable
  
  belongs_to :user
  has_many :events
  
  dragonfly_accessor :image
  accepts_translations_for :description
  
  before_update do
    self.url_fragment = name.gsub(/[^0-9A-Za-z]/,'').underscore.dasherize
  end
end
