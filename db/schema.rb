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

ActiveRecord::Schema.define(version: 20160314123731) do

  create_table "articles", force: :cascade do |t|
    t.string   "company_name"
    t.string   "facebook_uid"
    t.string   "twitter_uid"
    t.string   "name"
    t.string   "provider"
    t.text     "text"
    t.datetime "time"
    t.string   "photo_url"
    t.string   "link"
    t.string   "author"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "companies", force: :cascade do |t|
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
    t.string   "price"
    t.string   "telephone"
    t.string   "position"
  end

  add_index "companies", ["email"], name: "index_companies_on_email", unique: true
  add_index "companies", ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true

  create_table "social_users", force: :cascade do |t|
    t.string   "facebook_token"
    t.string   "twitter_token"
    t.string   "twitter_secret"
    t.string   "facebook_uid"
    t.string   "twitter_uid"
    t.string   "social_uid"
    t.string   "company_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stalked_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "pageid"
    t.integer  "company_id"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
