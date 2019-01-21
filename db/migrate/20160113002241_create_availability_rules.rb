class CreateAvailabilityRules < ActiveRecord::Migration
  def change
    create_table :availability_rules do |t|
      t.integer :artist_id
      t.boolean :is_exclusion
      t.timestamp :start_at
      t.timestamp :end_at
      t.time :from_time
      t.time :to_time
      t.string :days_json

      t.timestamps null: false
    end
  end
end
