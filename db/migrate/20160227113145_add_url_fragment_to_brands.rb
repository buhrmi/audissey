class AddUrlFragmentToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :url_fragment, :string
  end
end
