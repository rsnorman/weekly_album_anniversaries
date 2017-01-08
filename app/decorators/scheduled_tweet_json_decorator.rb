class ScheduledTweetJsonDecorator
  # Initialize decorator far an array of scheduled tweets
  # @param [Array<ScheduledTweet>, ScheduledTweet] scheduled tweets array to decorator
  def initialize(scheduled_tweets, singular: false)
    @scheduled_tweets = scheduled_tweets
    @singular = singular
  end

  # Returns json for scheduled tweets
  # @returns [String] json string for scheduled tweets
  def to_api_json
    Jbuilder.encode do |json|
      if singular?
        json.scheduled_tweet do
          scheduled_tweet_json(@scheduled_tweets, json)
        end
      else
        json.scheduled_tweets do
          json.array! @scheduled_tweets do |scheduled_tweet|
            scheduled_tweet_json(scheduled_tweet, json)
          end
        end
      end
    end
  end

  private

  def scheduled_tweet_json(scheduled_tweet, jbuilder_json)
    jbuilder_json.id scheduled_tweet.id
    jbuilder_json.artist scheduled_tweet.album.artist_name
    jbuilder_json.album scheduled_tweet.album.name
    jbuilder_json.type scheduled_tweet.type
    jbuilder_json.scheduled_on scheduled_tweet.scheduled_at.strftime('%A at %-l:%M %P')
    jbuilder_json.scheduled_at scheduled_tweet.scheduled_at.strftime('%F %T')
    jbuilder_json.set!(:link, "/v1/admin/scheduled_tweets/#{scheduled_tweet.id}")
  end

  def singular?
    @singular
  end
end
