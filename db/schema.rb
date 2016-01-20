# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160113024027) do

  create_table "availability_rules", force: :cascade do |t|
    t.integer  "offering_id"
    t.boolean  "is_exclusion"
    t.datetime "start_at"
    t.datetime "end_at"
    t.time     "from_time"
    t.time     "to_time"
    t.string   "days_json"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "offering_id"
    t.integer  "user_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "offerer_confirmed_at"
    t.datetime "buyer_confirmed_at"
    t.string   "note"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "categories", id: false, force: :cascade do |t|
    t.string   "name"
    t.string   "id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "credit_changes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "offering_id"
    t.integer  "delta"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "offerings", force: :cascade do |t|
    t.string   "actionable_name"
    t.text     "description"
    t.integer  "user_id"
    t.string   "image_uid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "category_id"
    t.integer  "duration"
    t.datetime "published_at"
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "take"
    t.string   "currency"
    t.integer  "buyable_id"
    t.string   "buyable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "give"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "buyable_id"
    t.string   "buyable_type"
    t.string   "price_json"
    t.integer  "buyer_id"
    t.string   "gateway_id"
    t.string   "gateway_tx_id"
    t.string   "gateway_user_id"
    t.datetime "gateway_confirmed_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file_name"
    t.string   "file_uid"
    t.string   "mime_type"
    t.string   "through"
    t.integer  "bytes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid"

end
