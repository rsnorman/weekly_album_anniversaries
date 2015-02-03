class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name,         null: false
      t.string :artist,       null: false
      t.date   :release_date, null: false
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
