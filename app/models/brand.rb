class Brand < ActiveRecord::Base
  include Translatable
  
  belongs_to :user
  
  accepts_translations_for :description
end
