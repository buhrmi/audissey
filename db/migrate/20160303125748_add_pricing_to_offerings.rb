class AddPricingToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :pricing, :string, :default => 'flexible'
  end
end
