require './lib/trie_dict'

class AlbumSearch
  FUZZY_LEVEL = 3

  def initialize(albums = Album.all)
    @albums = albums
    @album_searcher = TrieDict.new
    @artist_searcher = TrieDict.new
    albums.collect { |a| [a.name, a.artist.name] }.each do |album, artist|
      album_searcher.put(album)
      artist_searcher.put(artist)
    end
  end

  def search(query)
    query = query.downcase
    Album
      .where(
        'lower(albums.name) LIKE ? OR lower(artists.name) LIKE ?',
        "%#{query}%",
        "%#{query}%"
      )
      .joins(:artist)
      .or(find_fuzzy_matched_albums(query))
      .distinct
  end

  private

  attr_reader :albums, :album_searcher, :artist_searcher

  def find_fuzzy_matched_albums(query)
     Album.where(
       "lower(albums.name) IN (?) OR lower(artists.name) IN (?)",
       album_searcher.fetch(query, FUZZY_LEVEL),
       artist_searcher.fetch(query, FUZZY_LEVEL)
     ).joins(:artist)
  end
end
