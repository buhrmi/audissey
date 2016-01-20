class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :actionable_name
      t.text :description
      t.integer :user_id
      t.string :image_uid

      t.timestamps null: false
    end
  end
end
