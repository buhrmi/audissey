class AddPriceIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :price_id, :integer
  end
end
