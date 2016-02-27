class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :brand_id
      t.integer :venue_id
      t.string :flyer_image_uid
      t.string :flyer_image_name
      t.string :name
      t.timestamp :start_at
      t.timestamp :end_at

      t.timestamps null: false
    end
  end
end
