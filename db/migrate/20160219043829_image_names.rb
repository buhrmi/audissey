class ImageNames < ActiveRecord::Migration
  def change
    add_column :users, :image_name, :string
    add_column :artists, :image_name, :string
    add_column :artists, :management_image_name, :string
  end
end
