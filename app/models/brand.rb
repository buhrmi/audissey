# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Brand < ActiveRecord::Base
  include Translatable
  
  belongs_to :user
  has_many :events
  
  accepts_translations_for :description
end
