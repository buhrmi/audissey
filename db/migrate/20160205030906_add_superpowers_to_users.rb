class AddSuperpowersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :superpowers, :boolean
  end
end
