class ScheduledTweetJsonDecorator
  # Initialize decorator far an array of scheduled tweets
  # @param [Array<ScheduledTweet>] scheduled tweets array to decorator
  def initialize(scheduled_tweets)
    @scheduled_tweets = scheduled_tweets
  end

  # Returns json for scheduled tweets
  # @returns [String] json string for scheduled tweets
  def to_api_json
    Jbuilder.encode do |json|
      json.scheduled_tweets do
        json.array! @scheduled_tweets do |scheduled_tweet|
          json.id scheduled_tweet.id
          json.artist scheduled_tweet.album.artist_name
          json.album scheduled_tweet.album.name
          json.type scheduled_tweet.type
          json.scheduled_on scheduled_tweet.scheduled_at.strftime('%A at %-l:%M %P')
          json.set!(:link, "/v1/scheduled_tweets/#{scheduled_tweet.id}")
        end
      end
    end
  end
end
