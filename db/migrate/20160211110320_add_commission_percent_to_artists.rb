class AddCommissionPercentToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :commission_percent, :integer, :default => 15
  end
end
