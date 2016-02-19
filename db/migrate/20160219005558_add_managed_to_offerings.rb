class AddManagedToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :managed, :boolean
  end
end
