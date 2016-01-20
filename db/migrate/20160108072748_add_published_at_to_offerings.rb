class AddPublishedAtToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :published_at, :timestamp
  end
end
