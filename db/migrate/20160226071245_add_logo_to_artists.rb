class AddLogoToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :logo_image_uid, :string
    add_column :artists, :logo_image_name, :string
  end
end
