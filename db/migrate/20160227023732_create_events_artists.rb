class CreateEventsArtists < ActiveRecord::Migration
  def change
    create_table :events_artists do |t|
      t.integer :event_id
      t.integer :artist_id

      t.timestamps null: false
    end
  end
end
