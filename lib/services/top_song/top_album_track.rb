module TopSong
  # Returns the top Spotify album track for an album
  class TopAlbumTrack
    def self.top_for(album)
      new(album: album).top
    end

    def initialize(album:, spotify_client: RSpotify::Artist)
      @album = album
      @spotify_client = spotify_client
    end

    def top
      return unless spotify_album
      spotify_album.tracks.sort_by(&:popularity).reverse.first
    end

    private

    def spotify_album
      return unless spotify_artist
      @spotify_album ||= spotify_artist.albums.detect do |album|
        album.name == @album.name
      end
    end

    def spotify_artist
      @spotify_artist ||= @spotify_client.search(@album.artist.name).first
    end
  end
end
