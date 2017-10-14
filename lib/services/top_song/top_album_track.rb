module TopSong
  # Returns the top Spotify album track for an album
  class TopAlbumTrack
    def self.top_for(album)
      new(album: album).top
    end

    def initialize(album:, spotify_client: RSpotify)
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
        album.name.downcase == @album.name.downcase
      end

      unless @spotify_album
        album = @spotify_client::Album.search(@album.name).first
        @spotify_album = album if album && album.artists.any? do |artist|
          artist.name.downcase == @album.artist_name.downcase
        end
      end

      @spotify_album
    end

    def spotify_artist
      @spotify_artist ||= @spotify_client::Artist.search(@album.artist_name).first
    end
  end
end
