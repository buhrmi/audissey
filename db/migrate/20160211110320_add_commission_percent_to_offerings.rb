class AddCommissionPercentToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :commission_percent, :integer, :default => 15
  end
end
