class AddDurationToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :duration, :integer
  end
end
