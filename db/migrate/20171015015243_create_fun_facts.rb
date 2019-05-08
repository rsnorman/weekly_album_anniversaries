# frozen_string_literal: true

class CreateFunFacts < ActiveRecord::Migration[4.2]
  def change
    create_table :fun_facts do |t|
      t.references :album, index: true
      t.text :description
      t.string :source

      t.timestamps null: false
    end

    add_foreign_key :fun_facts, :albums
  end
end
