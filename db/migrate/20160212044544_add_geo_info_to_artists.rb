class AddGeoInfoToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :address, :string
    add_column :artists, :latitude, :float
    add_column :artists, :longitude, :float
  end
end
