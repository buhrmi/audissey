class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.string :method
      t.string :method_detail
      t.integer :user_id
      t.timestamp :completed_at
      t.integer :completed_by

      t.timestamps null: false
    end
  end
end
