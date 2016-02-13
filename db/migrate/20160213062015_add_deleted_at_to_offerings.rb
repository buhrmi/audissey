class AddDeletedAtToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :deleted_at, :timestamp
    add_index :offerings, :deleted_at
  end
end
