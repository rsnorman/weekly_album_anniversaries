require './app/queries/active_scheduled_tweet'
require_relative 'song_tweeter'
require_relative 'top_album_track'

# Tweets scheduled tweets for top songs
class TopSongScheduledTweeter
  def self.tweet_all
    new.tweet_all
  end

  def initialize(scheduled_tweets: ActiveScheduledTweet.songs,
                 song_tweeter: SongTweeter)
    @scheduled_tweets = scheduled_tweets
    @song_tweeter = song_tweeter
  end

  def tweet_all
    @scheduled_tweets.each do |scheduled_tweet|
      tweet = @song_tweeter.tweet_about(scheduled_tweet.album)
      scheduled_tweet.update(tweet_id: tweet.id)
    end
  end
end
