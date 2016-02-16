class AddCommissionPercentToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :commission_percent, :integer
  end
end
