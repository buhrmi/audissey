# == Schema Information
#
# Table name: translations
#
#  id                 :integer          not null, primary key
#  translatable_id    :integer
#  translatable_type  :string
#  translatable_field :string
#  locale             :string
#  text               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Translation < ActiveRecord::Base
end
