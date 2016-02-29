class HighlightDailyAnniversaryService
  include ActionView::Helpers::TextHelper

  def tweet
    return if highlighted_album.nil?
    HighlightedAlbum.create(album: highlighted_album)
    client.update(
      "#{highlighted_album.artist}'s \"#{highlighted_album.name}\" " \
      "turns #{pluralize(highlighted_album.anniversary.count, 'years')} old this week. " \
      "https://wistfulindie.herokuapp.com/albums/#{highlighted_album.slug} " \
      "#indiemusic #classicindie"
    )
  end

  private

  def highlighted_album
    @highlighted_album ||=
      WeeklyAnniversaryQuery.new(unhighlighted_albums).find_all.first
  end

  def unhighlighted_albums
    Album.where.not(id: HighlightedAlbum.pluck(:album_id))
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end
end
