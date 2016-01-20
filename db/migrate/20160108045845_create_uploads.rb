class CreateUploads < ActiveRecord::Migration
  def change
    create_table "uploads", force: :cascade do |t|
      t.integer  "user_id"
      t.string   "file_name"
      t.string   "file_uid"
      t.string   "mime_type"
      t.string   "through"
      t.integer  "bytes"
      t.timestamps null: false
    end
  end
end
