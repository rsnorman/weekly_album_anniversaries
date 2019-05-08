# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration[4.2]
  def change
    create_table :genres do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
