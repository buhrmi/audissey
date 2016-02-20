class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
  end
end
