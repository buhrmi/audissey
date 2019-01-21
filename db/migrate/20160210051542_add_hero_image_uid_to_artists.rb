class AddHeroImageUidToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :hero_image_uid, :string
  end
end
