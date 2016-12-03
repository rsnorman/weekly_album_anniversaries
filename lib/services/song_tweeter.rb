require_relative 'top_album_track'

# Tweets classic songs
class SongTweeter
  def initialize(album:,
                 twitter_client: WistfulIndie::Twitter::Client.client,
                 top_track_finder: TopAlbumTrack)
    @client = twitter_client
    @album = album
    raise ArgumentError, 'Must pass an album' if @album.nil?
    @top_track_finder = TopAlbumTrack.new(album: @album)
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
    @top_track ||= @top_track_finder.top
  end

  def spotify_url
    top_track.external_urls['spotify']
  end

  def artist_hashtag
    "##{artist.name.gsub(/[^a-zA-Z]*/, '')}"
  end

  def tweet_text
    ".@#{artist.twitter_screen_name}'s song \"#{top_track.name}\" is still " \
    "great after #{@album.anniversary.count} years #{spotify_url} " \
    "#{artist_hashtag} #indiemusic"
  end
end
