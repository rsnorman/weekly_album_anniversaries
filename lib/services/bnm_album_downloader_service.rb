require_relative 'extra_album_details_downloader_service'
require './lib/wistful_indie/twitter/screen_name_assigner'

class BnmAlbumDownloaderService
  require 'open-uri'

  DEFAULT_TIMEOUT = 5

  def initialize(options = {})
    @timeout = options[:timeout] || DEFAULT_TIMEOUT
    @inserted_albums = []
    @error_albums = []
  end

  def download
    page = get_page('http://pitchfork.com/reviews/best/albums/')

    while page
      get_albums(page).each do |album_node|
        album = Album.new
        begin
          artist_name = album_node.css('.info h1').text
          album.artist = Artist.find_by(name: artist_name)
          album.artist ||= Artist.create(name: artist_name)

          album.name = album_node.css('.info h2').text

          return unless Album.where(artist: album.artist, name: album.name).count.zero?

          album.thumbnail = album_node.css('.artwork div').attr('data-content').value.split('"')[1]
          album.link = "http://pitchfork.com#{album_node.css('.info a:first').attr('href')}"
          album.release_date = Date.strptime(album_node.css('.info h4').text.split(';').last.strip, "%B %d, %Y")
          album.rating = album_node.css('.score').text.strip
          album.save!

          ExtraAlbumDetailsDownloaderService.new(album).download
          WistfulIndie::Twitter::ScreenNameAssigner.new(album.artist).assign

          inserted_albums << album
        rescue
          error_albums << album if album.name
        end
      end

      inserted_albums.each do |album|
        puts "Inserted #{album.name} by #{album.artist}"
      end

      error_albums.each do |album|
        puts "Failed inserting #{album.name} by #{album.artist}"
      end

      page = get_next_page(page)

      sleep rand(1..@timeout)
    end
  end

  private

  attr_accessor :inserted_albums, :error_albums

  def get_page(url)
    Nokogiri::HTML(open(url))
  end

  def get_albums(page)
    page.css('.bnm-list li')
  end

  def get_next_page(page)
    next_link = page.css('.next-container .next')
    if next_link.size.zero?
      nil
    else
      get_page("http://pitchfork.com#{next_link.attr('href')}")
    end
  end
end
