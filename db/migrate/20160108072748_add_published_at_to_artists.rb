class AddPublishedAtToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :published_at, :timestamp
  end
end
