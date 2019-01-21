class AddApprovalToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :approved_at, :timestamp
    add_column :artists, :approved_by_id, :integer
  end
end
