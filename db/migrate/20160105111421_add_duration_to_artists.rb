class AddDurationToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :duration, :integer
  end
end
