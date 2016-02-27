class Event < ActiveRecord::Base
  include Translatable
  
  belongs_to :brand
  has_and_belongs_to_many :offerings
  
  accepts_translations_for :description
  
  dragonfly_accessor :flyer_image
end
