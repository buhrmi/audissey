# == Schema Information
#
# Table name: prices
#
#  id           :integer          not null, primary key
#  give         :integer          default(1)
#  take         :integer
#  currency     :string
#  buyable_id   :integer
#  buyable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Price < ActiveRecord::Base
  CURRENCIES = {
    'JPY' => {:symbol => '¥'}
    # 'USD' => {:symbol => '$'},
    # 'EUR' => {:symbol => '€'},
    # 'GBP' => {:symbol => '£'},
    # 'AUD' => {:symbol => '$'},
    # 'NZD' => {:symbol => '$'},
    # 'CAD' => {:symbol => '$'},
    # 'HKD' => {:symbol => '$'},
    # 'CHF' => {:symbol => ''},
    # 'NOK' => {:symbol => ''},
    # 'ZAR' => {:symbol => ''}
  }

  has_many :purchases
  belongs_to :buyable, :polymorphic => true
  
  validates :take, :numericality => { :greater_than => 0 }, :allow_nil => true
  validates :give, :numericality => { :greater_than => 0 }, :allow_nil => true

end
