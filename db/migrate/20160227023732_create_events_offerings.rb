class CreateEventsOfferings < ActiveRecord::Migration
  def change
    create_table :events_offerings do |t|
      t.integer :event_id
      t.integer :offering_id

      t.timestamps null: false
    end
  end
end
