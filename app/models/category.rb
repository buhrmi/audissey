# == Schema Information
#
# Table name: categories
#
#  name        :string
#  id          :string           primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ActiveRecord::Base
  self.primary_key = :id

  delete_all
  find_or_create_by :id => 'performer', :name => 'DJ / Producer'
  find_or_create_by :id => 'lighting', :name => 'VJ / Laser'
  find_or_create_by :id => 'venue', :name => 'Venue'
  find_or_create_by :id => 'photographer', :name => 'Photographer'
  find_or_create_by :id => 'catering', :name => 'Catering'
  find_or_create_by :id => 'other', :name => 'Other'
  find_or_create_by :id => 'model', :name => 'Model / Dancer'
  find_or_create_by :id => 'rental', :name => 'Rental Gear'

  has_many :artists


  scope :with_icon, lambda { all }

end
