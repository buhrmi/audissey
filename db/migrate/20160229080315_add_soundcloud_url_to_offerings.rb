class AddSoundcloudUrlToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :soundcloud_url, :string
    add_column :offerings, :mixcloud_url, :string
    add_column :offerings, :facebook_url, :string
    add_column :offerings, :twitter_id, :string
  end
end
