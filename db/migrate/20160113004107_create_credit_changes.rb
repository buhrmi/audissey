class CreateCreditChanges < ActiveRecord::Migration
  def change
    create_table :credit_changes do |t|
      t.integer :user_id
      t.integer :offering_id
      t.integer :delta
      t.integer :source_id
      t.string :source_type

      t.timestamps null: false
    end
  end
end
