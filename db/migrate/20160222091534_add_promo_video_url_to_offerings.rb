class AddPromoVideoUrlToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :promo_video_url, :string
  end
end
