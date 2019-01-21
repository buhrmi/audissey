class AddSoundcloudUrlToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :soundcloud_url, :string
    add_column :artists, :mixcloud_url, :string
    add_column :artists, :facebook_url, :string
    add_column :artists, :twitter_id, :string
  end
end
