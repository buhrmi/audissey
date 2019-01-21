class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :offering_id
      t.integer :user_id
      t.timestamp :start_at
      t.timestamp :end_at
      t.timestamp :artist_confirmed_at
      t.timestamp :buyer_confirmed_at
      t.string :note

      t.timestamps null: false
    end
  end
end
