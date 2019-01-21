class AddUrlFragmentToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :url_fragment, :string
  end
end
