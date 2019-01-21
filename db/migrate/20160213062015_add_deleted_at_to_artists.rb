class AddDeletedAtToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :deleted_at, :timestamp
    add_index :artists, :deleted_at
  end
end
