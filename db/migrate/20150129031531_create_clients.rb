class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name,                  null: false
      t.string :week_start_preference, null: false, default: "monday"

      t.timestamps null: false
    end
  end
end
