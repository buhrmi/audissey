# == Schema Information
#
# Table name: credit_changes
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  artist_id :integer
#  delta       :integer
#  source_id   :integer
#  source_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CreditChange < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist

  belongs_to :source, :polymorphic => true
end
