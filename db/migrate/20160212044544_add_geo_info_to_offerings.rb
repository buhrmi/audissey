class AddGeoInfoToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :address, :string
    add_column :offerings, :latitude, :float
    add_column :offerings, :longitude, :float
  end
end
