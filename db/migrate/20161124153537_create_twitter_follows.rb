# frozen_string_literal: true

class CreateTwitterFollows < ActiveRecord::Migration[4.2]
  def change
    create_table :twitter_follows do |t|
      t.string :twitter_id
      t.string :screen_name
      t.boolean :is_friend, default: false
      t.references :artist, null: true

      t.timestamps null: false
    end
  end
end
