require './app/queries/active_scheduled_tweet'
require './lib/services/top_song/song_tweeter'

module TweetSchedule
  # Tweets scheduled tweets for top songs
  class TopSongScheduledTweeter
    def self.tweet_all
      new.tweet_all
    end

    def initialize(scheduled_tweets: ActiveScheduledTweet.all.songs,
                   song_tweeter: TopSong::SongTweeter)
      @scheduled_tweets = scheduled_tweets
      @song_tweeter = song_tweeter
    end

    def tweet_all
      @scheduled_tweets.each do |scheduled_tweet|
        begin
          tweet = @song_tweeter.tweet_about(scheduled_tweet.album)
          if tweet
            scheduled_tweet.update(tweet_id: tweet.id)
          else
            Rollbar.warning(
              'Could not find top song for ' \
              "#{scheduled_tweet.album.artist.name} -" \
              " #{scheduled_tweet.album.name}")
            scheduled_tweet.update(tweet_id: -1)
          end
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
