class AddEscrowNotesToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :escrow_notes, :text
  end
end
