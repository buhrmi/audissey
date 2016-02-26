class AddUrlFragmentToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :url_fragment, :string
  end
end
