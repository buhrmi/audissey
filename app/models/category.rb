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
  find_or_create_by :id => 'performer', :name => 'DJ / Performance'
  find_or_create_by :id => 'venue',         :name => 'Venue'
  find_or_create_by :id => 'organizer',     :name => 'Organizing'

  has_many :offerings


  scope :with_icon, lambda { all }

end
