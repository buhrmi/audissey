class AddManagedToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :managed, :boolean
  end
end
