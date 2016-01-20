class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, :id => false do |t|
      t.string :name
      t.string :id
      t.string :description

      t.timestamps null: false
    end
  end
end
