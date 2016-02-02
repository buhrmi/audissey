class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :topicable_id
      t.string :topicable_type
      t.integer :sender_id
      t.text :text

      t.timestamps null: false
    end
  end
end
