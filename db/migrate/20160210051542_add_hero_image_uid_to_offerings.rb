class AddHeroImageUidToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :hero_image_uid, :string
  end
end
