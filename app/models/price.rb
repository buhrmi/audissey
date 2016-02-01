# == Schema Information
#
# Table name: prices
#
#  id           :integer          not null, primary key
#  take         :integer
#  currency     :string
#  buyable_id   :integer
#  buyable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  give         :integer
#

class Price < ActiveRecord::Base
  CURRENCIES = [
    'JPY', 'USD', 'AUD', 'NZD', 'GBP', 'CAD', 'CHF', 'EUR', 'HKD', 'NOK', 'ZAR'
  ]

  belongs_to :buyable, :polymorphic => true
end
