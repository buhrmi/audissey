class AddApprovalToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :approved_at, :timestamp
    add_column :offerings, :approved_by_id, :integer
  end
end
