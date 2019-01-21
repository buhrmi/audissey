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

class Event < ActiveRecord::Base
  include Translatable
  
  belongs_to :brand
  has_and_belongs_to_many :artists
  
  accepts_translations_for :description
  
  dragonfly_accessor :flyer_image
end
