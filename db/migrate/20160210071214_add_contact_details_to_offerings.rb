class AddContactDetailsToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :contact_details, :text
  end
end
