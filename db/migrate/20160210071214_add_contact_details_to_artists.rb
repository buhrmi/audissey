class AddContactDetailsToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :contact_details, :text
  end
end
