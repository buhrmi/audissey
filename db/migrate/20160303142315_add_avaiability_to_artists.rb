class AddAvaiabilityToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :availability, :string, :default => 'confirm'
  end
end
