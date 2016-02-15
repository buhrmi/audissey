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
  find_or_create_by :id => 'performer', :name => 'DJ'
  find_or_create_by :id => 'venue',         :name => 'Venue'
  find_or_create_by :id => 'organizer',     :name => 'Organizer'
  find_or_create_by :id => 'photographer',     :name => 'Photographer'
  find_or_create_by :id => 'catering',     :name => 'Catering'

  has_many :offerings


  scope :with_icon, lambda { all }

end
