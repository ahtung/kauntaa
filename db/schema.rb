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

ActiveRecord::Schema.define(version: 20150331200821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "bsn", limit: 255
  end

  add_index "admins", ["bsn"], name: "index_admins_on_bsn", using: :btree

  create_table "bsn_login_failures", force: :cascade do |t|
    t.string   "ipaddress",  limit: 255
    t.datetime "created_at"
  end

  add_index "bsn_login_failures", ["ipaddress"], name: "i_bsn_login_failures_ipaddress", using: :btree

  create_table "counters", force: :cascade do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "email_used_to_cast_votes", force: :cascade do |t|
    t.string  "hashed_email",           limit: 255
    t.integer "number_of_votes_casted",             default: 0
  end

  add_index "email_used_to_cast_votes", ["hashed_email"], name: "i_ema_use_to_cas_vot_has_ema", using: :btree

  create_table "palettes", force: :cascade do |t|
    t.string   "foreground_color"
    t.string   "background_color"
    t.string   "text_color"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "pending_email_confirmations", force: :cascade do |t|
    t.string "token", limit: 255
    t.string "email", limit: 255
  end

  add_index "pending_email_confirmations", ["token"], name: "i_pen_ema_con_tok", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "voters", id: false, force: :cascade do |t|
    t.string "bsn",                          limit: 255
    t.date   "date_of_birth"
    t.string "token",                        limit: 255
    t.string "status",                       limit: 255
    t.string "auth_method",                  limit: 255
    t.string "voted_on_date",                limit: 255
    t.string "background_data",              limit: 4000
    t.string "transferable_background_data", limit: 4000
  end

  add_index "voters", ["bsn", "date_of_birth"], name: "i_voters_bsn_date_of_birth", using: :btree
  add_index "voters", ["token"], name: "index_voters_on_token", using: :btree

  create_table "votes", force: :cascade do |t|
    t.string  "token",            limit: 255
    t.string  "status",           limit: 255
    t.integer "voting_option_id"
    t.string  "background_data",  limit: 4000
  end

  add_index "votes", ["token"], name: "index_votes_on_token", using: :btree

  create_table "voting_options", force: :cascade do |t|
    t.string "title", limit: 255
  end

end
