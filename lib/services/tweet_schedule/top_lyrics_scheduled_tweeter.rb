require './app/queries/active_scheduled_tweet'
require './lib/services/lyrics/lyrics_tweeter'

module TweetSchedule
  # Tweets scheduled tweets for top songs
  class TopLyricsScheduledTweeter
    def self.tweet_all
      new.tweet_all
    end

    def initialize(scheduled_tweets: ActiveScheduledTweet.all.lyrics,
                   lyrics_tweeter: Lyrics::LyricsTweeter)
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
