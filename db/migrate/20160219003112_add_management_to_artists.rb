class AddManagementToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :management_name, :string
    add_column :artists, :management_email, :string
    add_column :artists, :management_image_uid, :string
  end
end
