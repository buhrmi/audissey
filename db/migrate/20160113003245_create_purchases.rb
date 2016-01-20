class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :buyable_id
      t.string :buyable_type
      t.string :price_json
      t.integer :buyer_id

      t.string :gateway_id
      t.string :gateway_tx_id
      t.string :gateway_user_id

      t.timestamp :gateway_confirmed_at

      t.timestamps null: false
    end
  end
end
