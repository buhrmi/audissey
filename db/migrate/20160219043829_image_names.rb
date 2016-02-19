class ImageNames < ActiveRecord::Migration
  def change
    add_column :users, :image_name, :string
    add_column :offerings, :image_name, :string
    add_column :offerings, :management_image_name, :string
  end
end
