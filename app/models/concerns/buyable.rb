module Buyable
  extend ActiveSupport::Concern

  included do
    has_many :prices, :as => 'buyable'
    accepts_nested_attributes_for :prices, :allow_destroy => true

    has_many :purchases, :as => 'buyable'

  end
end
