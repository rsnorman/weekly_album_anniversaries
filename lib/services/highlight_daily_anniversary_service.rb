class HighlightDailyAnniversaryService
  include ActionView::Helpers::TextHelper

  def tweet
    return if highlighted_album.nil?
    HighlightedAlbum.create(album: highlighted_album)
    client.update_with_media(tweet_content, album_image_file)
  ensure
    delete_album_image
  end

  private

  def tweet_content
    "#{artist_possesive} \"#{highlighted_album.name}\" " \
    "turns #{pluralize(highlighted_album.anniversary.count, 'years')} old this week. " \
    "https://wistfulindie.herokuapp.com/albums/#{highlighted_album.slug} " \
    "#indiemusic #classicindie"
  end

  def artist_possesive
    name = highlighted_album.artist
    name[-1] == 's' ? "#{name}'" : "#{name}'s"
  end

  def album_image_file
    return @album_image_file if @album_image_file
    save_album_image
    @album_image_path = File.open(album_image_path)
  end

  def save_album_image
    File.open(album_image_path, 'w', encoding: 'ascii-8bit') do |f|
      f << download_album_image
    end
  end

  def delete_album_image
    album_image_file.close
    File.unlink(album_image_file)
  end

  def download_album_image
    require 'open-uri'
    open(highlighted_album.thumbnail) { |f| f.read }
  end

  def album_image_path
    "./tmp/#{highlighted_album.slug}.jpg"
  end

  def highlighted_album
    @highlighted_album ||=
      WeeklyAnniversaryQuery.new(unhighlighted_albums).find_all.detect do |album|
        album.anniversary.current == Date.current
      end
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
