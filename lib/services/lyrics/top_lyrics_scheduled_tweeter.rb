require './app/queries/active_scheduled_tweet'
require_relative 'lyrics_tweeter'
require_relative '../top_album_track'

module Lyrics
  # Tweets scheduled tweets for top songs
  class TopLyricsScheduledTweeter
    def self.tweet_all
      new.tweet_all
    end

    def initialize(scheduled_tweets: ActiveScheduledTweet.lyrics,
                   lyrics_tweeter: LyricsTweeter)
      @scheduled_tweets = scheduled_tweets
      @lyrics_tweeter = lyrics_tweeter
    end

    def tweet_all
      @scheduled_tweets.each do |scheduled_tweet|
        tweet = @lyrics_tweeter.tweet_about(scheduled_tweet.album)
        scheduled_tweet.update(tweet_id: tweet.id)
      end
    end
  end
end
