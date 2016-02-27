class AddImageToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :image_uid, :string
    add_column :brands, :image_name, :string
  end
end
