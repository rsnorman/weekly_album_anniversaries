# Favorites as many tweets given until rate limit reached
class TweetsFavoritor
  def self.favorite_all(tweets)
    new(tweets: tweets).favorite_all
  end

  def initialize(tweets:, twitter_client: WistfulIndie::Twitter::Client)
    @tweets = tweets
    @client = twitter_client
  end

  def favorite_all
    @tweets.each do |tweet|
      @client.favorite(tweet)
    end
  end
end

