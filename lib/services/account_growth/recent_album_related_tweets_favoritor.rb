require_relative 'artist_related_tweets'
require_relative 'tweets_favoritor'

module AccountGrowth
  class RecentAlbumRelatedTweetsFavoritor
    def self.favorite_all
      album = RecentHighlightedAlbum.find
      return unless album
      related_tweets = ArtistRelatedTweets.all(album.artist)
      TweetsFavoritor.favorite_all(related_tweets)
    end
  end
end
