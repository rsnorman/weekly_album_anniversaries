# frozen_string_literal: true

class CreatePotentialTwitterScreenNames < ActiveRecord::Migration[4.2]
  def change
    create_table :potential_twitter_screen_names do |t|
      t.references :artist, index: true
      t.string :screen_name
      t.integer :strength

      t.timestamps null: false
    end
    add_foreign_key :potential_twitter_screen_names, :artists
  end
end
