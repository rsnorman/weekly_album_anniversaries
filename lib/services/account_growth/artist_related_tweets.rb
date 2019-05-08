# frozen_string_literal: true

module AccountGrowth
  # Return tweets that are related to an artist
  class ArtistRelatedTweets
    SYSTEM_TWITTER_ID = 704_175_249_202_540_544
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
        .reject { |tweet| tweet.user.id == SYSTEM_TWITTER_ID }
    end

    def artist_search_query
      "#{@artist.name} #np -rt"
    end
  end
end
