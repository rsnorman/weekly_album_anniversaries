class AddAlbumSlug < ActiveRecord::Migration
  class MigrationAlbum < ActiveRecord::Base
    self.table_name = 'albums'

    def set_slug
      self.slug = Slugger.slug(artist, name)
    end
  end

  def change
    add_column :albums, :slug, :string
    MigrationAlbum.all.each do |album|
      album.set_slug
      album.save
    end
  end
end
