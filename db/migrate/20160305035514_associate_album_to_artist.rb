# frozen_string_literal: true

class AssociateAlbumToArtist < ActiveRecord::Migration[4.2]
  class MigrationAlbum < ActiveRecord::Base
    self.table_name = 'albums'
  end

  class MigrationArtist < ActiveRecord::Base
    self.table_name = 'artists'
  end

  def change
    add_column :albums, :artist_id, :integer
    add_index :albums, :artist_id
    MigrationAlbum.all.each do |album|
      artist   = MigrationArtist.find_by(name: album.artist)
      artist ||= MigrationArtist.create(name: album.artist)
      album.update(artist_id: artist.id)
    end
    add_foreign_key :albums, :artists
  end
end
