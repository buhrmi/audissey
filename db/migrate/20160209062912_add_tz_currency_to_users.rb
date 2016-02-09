class AddTzCurrencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tz, :string
    add_column :users, :currency, :string
  end
end
