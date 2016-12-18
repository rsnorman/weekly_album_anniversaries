# Return tweets that are related to an artist
class ArtistRelatedTweets
  SYSTEM_TWITTER_ID = 704175249202540544
  MAX_RELATED_TWEETS = 5

  def self.all(artist)
    new(artist: artist).all
  end

  def initialize(artist:, twitter_client: WistfulIndie::Twitter::Client.client)
    @artist = artist
    @client = twitter_client
  end

  def all
    related_tweets
  end

  private

  def related_tweets
    @client
      .search(artist_search_query, filter: :safe)
      .take(MAX_RELATED_TWEETS)
      .select { |tweet| tweet.user.id != SYSTEM_TWITTER_ID }
  end

  def artist_search_query
    "#{@artist.name} #np -rt"
  end
end
