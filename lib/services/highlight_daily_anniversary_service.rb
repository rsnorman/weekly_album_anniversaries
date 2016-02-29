class HighlightDailyAnniversaryService
  include ActionView::Helpers::TextHelper

  def tweet
    return if highlighted_album.nil?
    client.update(
      "#{highlighted_album.artist}'s \"#{highlighted_album.name}\" " \
      "turns #{pluralize(highlighted_album.anniversary.count, 'years')} old today. " \
      "https://wistfulindie.herokuapp.com/albums/#{highlighted_album.slug} " \
      "#indiemusic #classicindie"
    )
  end

  private

  def highlighted_album
    @highlighted_album ||= WeeklyAnniversaryQuery.new.find_all.select do |album|
      album.anniversary.current == Date.today
    end.first
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
