class AddLogoToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :logo_image_uid, :string
    add_column :offerings, :logo_image_name, :string
  end
end
