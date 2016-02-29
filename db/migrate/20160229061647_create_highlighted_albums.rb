class CreateHighlightedAlbums < ActiveRecord::Migration
  def change
    create_table :highlighted_albums do |t|
      t.references :album

      t.timestamps null: false
    end
  end
end
