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
  find_or_create_by :id => 'music_production', :name => 'Music Production'
  find_or_create_by :id => 'djing', :name => 'DJing'
  find_or_create_by :id => 'programming', :name => 'Programming'
  find_or_create_by :id => 'creative', :name => 'Creative Design'
  find_or_create_by :id => 'business', :name => 'Business'
  find_or_create_by :id => 'fashion_beauty', :name => 'Fashion & Beauty'
  find_or_create_by :id => 'lifestyle', :name => 'Lifestyle'

  has_many :offerings
end
