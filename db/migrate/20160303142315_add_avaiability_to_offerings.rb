class AddAvaiabilityToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :availability, :string, :default => 'confirm'
  end
end
