# frozen_string_literal: true

require './app/queries/active_scheduled_tweet'
require_relative '../album_anniversary/album_anniversary_tweeter'

module TweetSchedule
  # Tweets scheduled tweets for top songs
  class AlbumAnniversaryScheduledTweeter
    def self.tweet_all
      new.tweet_all
    end

    def initialize(scheduled_tweets: ActiveScheduledTweet.all.albums,
                   album_tweeter: AlbumAnniversary::AlbumAnniversaryTweeter)
      @scheduled_tweets = scheduled_tweets
      @album_tweeter = album_tweeter
    end

    def tweet_all
      @scheduled_tweets.each do |scheduled_tweet|
        begin
          tweet = @album_tweeter.tweet(scheduled_tweet.album)
          scheduled_tweet.update(tweet_id: tweet ? tweet.id : -1)
        rescue Exception => e
          Rollbar.error(e, type: scheduled_tweet.type,
                           artist: scheduled_tweet.album.name,
                           artist: scheduled_tweet.album.artist_name)
          scheduled_tweet.update(tweet_id: -1)
        end
      end
    end
  end
end
