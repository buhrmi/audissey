# == Schema Information
#
# Table name: credit_changes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  offering_id :integer
#  delta       :integer
#  source_id   :integer
#  source_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CreditChange < ActiveRecord::Base
end
