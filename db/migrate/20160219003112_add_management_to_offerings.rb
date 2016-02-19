class AddManagementToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :management_name, :string
    add_column :offerings, :management_email, :string
    add_column :offerings, :management_image_uid, :string
  end
end
