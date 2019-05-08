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
        begin
          tweet = @lyrics_tweeter.tweet_about(scheduled_tweet.album)
          if tweet
            scheduled_tweet.update(tweet_id: tweet.id)
          else
            Rollbar.warning(
              'Could not find top lyrics for ' \
              "#{scheduled_tweet.album.artist.name} -" \
              " #{scheduled_tweet.album.name}")
            scheduled_tweet.update(tweet_id: -1)
          end
        rescue Exception => e
          Rollbar.error(e, type: scheduled_tweet.type,
                           album: scheduled_tweet.album.name,
                           artist: scheduled_tweet.album.artist_name)
          scheduled_tweet.update(tweet_id: -1)
        end
      end
    end
  end
end
