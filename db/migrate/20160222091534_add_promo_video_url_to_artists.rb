class AddPromoVideoUrlToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :promo_video_url, :string
  end
end
