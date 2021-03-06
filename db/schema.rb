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

ActiveRecord::Schema.define(version: 2016_12_03_235549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "isbn_10"
    t.boolean "has_kindle_edition"
    t.integer "user_id"
    t.date "kindle_edition_release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notified", default: false
    t.date "release_date"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "uid", null: false
    t.string "provider", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_notification", default: false
    t.boolean "browser_notification", default: false
    t.string "browser_subscription_id"
    t.boolean "pushbullet_notification", default: false
    t.string "pushbullet_api_token"
  end

  add_foreign_key "books", "users"
end
