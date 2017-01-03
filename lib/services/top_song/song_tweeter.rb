require_relative 'top_album_track'

module TopSong
  # Tweets classic songs
  class SongTweeter
    def self.tweet_about(album)
      new(album: album).tweet
    end

    def initialize(album:,
                   twitter_client: WistfulIndie::Twitter::Client.client,
                   top_track_finder: TopAlbumTrack,
                   song_url_finder: YoutubeClient)
      @client = twitter_client
      @album = album
      raise ArgumentError, 'Must pass an album' if @album.nil?
      @top_track_finder = top_track_finder
      @song_url_finder = song_url_finder
    end

    def tweet
      return unless top_track
      puts "Tweeting top song for #{artist.name} - #{top_track.name}"
      @client.update(tweet_text)
    end

    private

    def artist
      @album.artist
    end

    def top_track
      @top_track ||= @top_track_finder.top_for(@album)
    end

    def song_url
      @song_url_finder.find("#{artist.name} #{top_track.name}")
    end

    def artist_hashtag
      "##{artist.name.gsub(/[^a-zA-Z]*/, '')}"
    end

    def tweet_text
      ".@#{artist.twitter_screen_name}'s song \"#{top_track.name}\" is still " \
      "great after #{@album.anniversary.count} years #{song_url} " \
      "#{artist_hashtag} #indiemusic"
    end
  end
end