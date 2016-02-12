class AddLocationIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :location_id, :integer
  end
end
