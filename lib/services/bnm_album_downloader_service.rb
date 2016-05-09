require_relative 'extra_album_details_downloader_service'
require './lib/wistful_indie/twitter/screen_name_assigner'

class BnmAlbumDownloaderService
  include ActionView::Helpers::SanitizeHelper

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
          artist_name = album_node.css('.artist-list li').text
          album.artist = Artist.find_by(name: artist_name)
          album.artist ||= Artist.create(name: artist_name)

          album.name = album_node.css('.title').text

          return unless Album.where(artist: album.artist, name: album.name).count.zero?

          album.thumbnail = album_node.css('.artwork img').attr('src').value
          album.link = "http://pitchfork.com#{album_node.css('.album-link').attr('href')}"
          album.release_date = Date.strptime(album_node.css('.pub-date').text, "%B %d %Y")

          review_page = get_page(album.link)
          album.rating = review_page.css('.score').text.strip
          album.image = review_page.css('.album-art img').attr('src').value
          album.review_blurb = review_page.css('.abstract').text.encode("iso-8859-1").force_encoding("utf-8").encode('utf-8', replace: nil)

          binding.pry

          album.save!

          WistfulIndie::Twitter::ScreenNameAssigner.new(album.artist).assign

          inserted_albums << album
        rescue StandardError => e
          puts "Failed because of #{e.inspect}"
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
    page.css('.review')
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

BnmAlbumDownloaderService.new.download
