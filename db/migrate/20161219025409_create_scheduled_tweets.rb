# frozen_string_literal: true

class CreateScheduledTweets < ActiveRecord::Migration[4.2]
  def change
    create_table :scheduled_tweets do |t|
      t.string :type
      t.datetime :scheduled_at
      t.references :album, index: true
      t.string :tweet_id

      t.timestamps null: false
    end
    add_foreign_key :scheduled_tweets, :albums
  end
end
