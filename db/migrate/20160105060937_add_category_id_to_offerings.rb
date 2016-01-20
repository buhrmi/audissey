class AddCategoryIdToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :category_id, :string
  end
end
