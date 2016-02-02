class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :give, :default => 1
      t.integer :take
      t.string :currency
      t.integer :buyable_id
      t.string :buyable_type

      t.timestamps null: false
    end
  end
end
