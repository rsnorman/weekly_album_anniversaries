require './lib/wistful_indie/twitter/client'

class HighlightDailyAnniversaryService
  include ActionView::Helpers::TextHelper

  def tweet
    return if highlighted_album.nil?
    HighlightedAlbum.transaction do
      HighlightedAlbum.create(album: highlighted_album)
      puts "Tweeting for #{highlighted_album.artist.name} - #{highlighted_album.name}"
      begin
        client.update_with_media(tweet_content, album_image_file)
      rescue Twitter::Error::Forbidden => e
        if e.message == 'Status is over 140 characters.'
          begin
            client.update_with_media(tweet_content(shortness_level: 1), album_image_file)
          rescue Twitter::Error::Forbidden => e
            if e.message == 'Status is over 140 characters.'
              client.update_with_media(tweet_content(shortness_level: 2), album_image_file)
            end
          end
        end
      end
    end
  ensure
    delete_album_image if highlighted_album
  end

  private

  def tweet_content(shortness_level: 0)
    content = "#{artist_possesive} \"#{highlighted_album.name}\" " \
    "turns #{pluralize(highlighted_album.anniversary.count, 'years')} old this week. "
    if shortness_level < 2
      content += "https://wistfulindie.herokuapp.com/albums/#{highlighted_album.slug} "
    end
    content += "#{hash_tags(without_artist: shortness_level > 0)}"
  end

  def artist_possesive
    name = artist_name
    name[-1] == 's' ? "#{name}'" : "#{name}'s"
  end

  def artist_name
    if (screen_name = highlighted_album.artist.twitter_screen_name)
      ".@#{screen_name}"
    else
      highlighted_album.artist.name
    end
  end

  def hash_tags(without_artist: false)
    unless without_artist
      "#indiemusic ##{highlighted_album.artist.name.gsub(/[^a-zA-Z]*/, '')}"
    else
      '#indiemusic'
    end
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
    open(highlighted_album.image || highlighted_album.thumbnail) { |f| f.read }
  end

  def album_image_path
    "./tmp/#{highlighted_album.slug}.jpg"
  end

  def highlighted_album
    return @highlighted_album if @highlighted_album

    @highlighted_album = WeeklyAnniversaryQuery.new(
      unhighlighted_albums
    ).find_all.detect do |album|
      album.anniversary.current == Date.current
    end
  end

  def unhighlighted_albums
    Album.where.not(id: HighlightedAlbum.pluck(:album_id))
  end

  def client
    WistfulIndie::Twitter::Client.client
  end
end
