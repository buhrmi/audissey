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
  find_or_create_by :id => 'performer', :name => 'DJs / Performers'
  find_or_create_by :id => 'venue',         :name => 'Venues'
  find_or_create_by :id => 'organizer',     :name => 'Organizers'

  has_many :offerings
end
