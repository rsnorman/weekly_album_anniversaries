# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_171_015_015_243) do
  create_table 'albums', force: :cascade do |t|
    t.string 'name', null: false
    t.date 'release_date', null: false
    t.string 'thumbnail'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'genre_id'
    t.string 'uuid'
    t.decimal 'rating', precision: 2, scale: 1
    t.string 'link'
    t.string 'slug'
    t.text 'review_blurb'
    t.string 'image'
    t.integer 'artist_id'
    t.index ['artist_id'], name: 'index_albums_on_artist_id'
  end

  create_table 'artists', force: :cascade do |t|
    t.string 'name'
    t.string 'uuid'
    t.string 'twitter_screen_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'fun_facts', force: :cascade do |t|
    t.integer 'album_id'
    t.text 'description'
    t.string 'source'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['album_id'], name: 'index_fun_facts_on_album_id'
  end

  create_table 'genres', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'uuid'
  end

  create_table 'highlighted_albums', force: :cascade do |t|
    t.integer 'album_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'potential_twitter_screen_names', force: :cascade do |t|
    t.integer 'artist_id'
    t.string 'screen_name'
    t.integer 'strength'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['artist_id'], name: 'index_potential_twitter_screen_names_on_artist_id'
  end

  create_table 'scheduled_tweets', force: :cascade do |t|
    t.string 'type'
    t.datetime 'scheduled_at'
    t.integer 'album_id'
    t.string 'tweet_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['album_id'], name: 'index_scheduled_tweets_on_album_id'
  end

  create_table 'twitter_follows', force: :cascade do |t|
    t.string 'twitter_id'
    t.string 'screen_name'
    t.boolean 'is_friend', default: false
    t.integer 'artist_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
