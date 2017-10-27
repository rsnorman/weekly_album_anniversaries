require './app/queries/active_scheduled_tweet'
require './lib/services/fun_facts/fun_fact_tweeter'

module TweetSchedule
  # Tweets scheduled tweets for fun facts
  class FunFactsScheduledTweeter
    def self.tweet_all
      new.tweet_all
    end

    def initialize(scheduled_tweets: ActiveScheduledTweet.all.fun_facts,
                   fun_fact_tweeter: FunFacts::FunFactTweeter)
      @scheduled_tweets = scheduled_tweets
      @fun_fact_tweeter = fun_fact_tweeter
    end

    def tweet_all
      @scheduled_tweets.each do |scheduled_tweet|
        puts "Tweet fun fact about #{scheduled_tweet.album.name}"
        begin
          tweet = @fun_fact_tweeter.tweet_about(scheduled_tweet.album)
          if tweet
            scheduled_tweet.update(tweet_id: tweet.id)
          else
            Rollbar.warning(
              'No fun fact available for ' \
              "#{scheduled_tweet.album.artist.name} -" \
              " #{scheduled_tweet.album.name}")
            scheduled_tweet.update(tweet_id: -1)
          end
        rescue Exception => e
          puts e.inspect
          Rollbar.error(e, type: scheduled_tweet.type,
                           album: scheduled_tweet.album.name,
                           artist: scheduled_tweet.album.artist_name)
          scheduled_tweet.update(tweet_id: -1)
        end
      end
    end
  end
end
