require './lib/trie_dict'

class AlbumSearch
  FUZZY_LEVEL = 3

  def initialize(albums = Album.all)
    @albums = albums
    @album_searcher = TrieDict.new
    @artist_searcher = TrieDict.new
    albums.pluck(:name, :artist).each do |album, artist|
      album_searcher.put(album)
      artist_searcher.put(artist)
    end
  end

  def search(query)
    query = query.downcase
    Album.where('lower(name) LIKE ? OR lower(artist) LIKE ?', "%#{query}%", "%#{query}%")
      .concat(Album.where(name: album_searcher.fetch(query, FUZZY_LEVEL)))
      .concat(Album.where(artist: artist_searcher.fetch(query, FUZZY_LEVEL))).uniq
  end

  private

  attr_reader :albums, :album_searcher, :artist_searcher
end
