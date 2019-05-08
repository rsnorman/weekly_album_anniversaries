class DropArtistColumnFromAlbum < ActiveRecord::Migration[4.2]
  def change
    remove_column :albums, :artist, :string
  end
end
