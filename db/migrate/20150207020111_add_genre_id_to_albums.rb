class AddGenreIdToAlbums < ActiveRecord::Migration[4.2]
  def change
    add_column :albums, :genre_id, :integer
  end
end
