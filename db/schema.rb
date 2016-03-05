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

ActiveRecord::Schema.define(version: 20160305035514) do

  create_table "albums", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "artist",                               null: false
    t.date     "release_date",                         null: false
    t.string   "thumbnail"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "genre_id"
    t.string   "uuid"
    t.decimal  "rating",       precision: 2, scale: 1
    t.string   "link"
    t.string   "slug"
    t.text     "review_blurb"
    t.string   "image"
    t.integer  "artist_id"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "uuid"
    t.string   "twitter_screen_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uuid"
  end

  create_table "highlighted_albums", force: :cascade do |t|
    t.integer  "album_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
