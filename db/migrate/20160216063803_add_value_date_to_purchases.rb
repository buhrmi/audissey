class AddValueDateToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :value_date, :timestamp
  end
end
