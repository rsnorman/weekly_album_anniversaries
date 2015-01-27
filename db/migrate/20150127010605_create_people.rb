class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name,          null: false
      t.date   :date_of_birth, null: false
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
