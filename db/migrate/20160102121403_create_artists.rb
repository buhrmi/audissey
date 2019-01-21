class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :image_uid

      t.timestamps null: false
    end
  end
end
