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

ActiveRecord::Schema.define(version: 20161108111926) do

  create_table "attends", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "details_images", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.string   "photo",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.text     "summary",          limit: 65535
    t.text     "details",          limit: 65535
    t.integer  "status",           limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",            limit: 255
    t.string   "dest",             limit: 255
    t.date     "apply_start_date"
    t.date     "apply_end_date"
    t.integer  "price",            limit: 4,     default: 0
    t.integer  "favorites_count",  limit: 4,     default: 0
    t.integer  "attends_count",    limit: 4,     default: 0
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "event_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "reading",    limit: 255
    t.string   "latitude",   limit: 255
    t.string   "longitude",  limit: 255
    t.string   "kind",       limit: 255
    t.integer  "layer",      limit: 4
    t.integer  "code",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "avatar",                 limit: 255
    t.string   "f_name",                 limit: 255
    t.string   "l_name",                 limit: 255
    t.text     "profile",                limit: 65535
    t.integer  "gender",                 limit: 4
    t.date     "birthday"
    t.string   "address_pref",           limit: 255
    t.string   "address_details",        limit: 255
    t.string   "tel",                    limit: 255
    t.integer  "attends_count",          limit: 4,     default: 0
    t.integer  "favorites_count",        limit: 4,     default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
