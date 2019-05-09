# frozen_string_literal: true

require_relative 'extra_album_details_downloader_service'
require './lib/wistful_indie/twitter/screen_name_assigner'

module AlbumDownload
  class BnmAlbumDownloaderService
    require 'open-uri'

    DEFAULT_TIMEOUT = 5

    def initialize(options = {})
      @timeout = options[:timeout] || DEFAULT_TIMEOUT
      @inserted_albums = []
      @error_albums = []
      @reviews_url = options[:reviews_url] || 'https://pitchfork.com/reviews/best/albums/'
    end

    def download
      page = get_page(@reviews_url)

      while page
        get_albums(page).each do |album_node|
          album = download_album(album_node)

          # rubocop:disable Lint/NonLocalExitFromIterator
          return unless album
          # rubocop:enable Lint/NonLocalExitFromIterator
        end

        inserted_albums.each do |album|
          puts "Inserted #{album.name} by #{album.artist.name}"
        end

        error_albums.each do |album|
          puts "Failed inserting #{album.name} by #{album.artist.name}"
        end

        page = get_next_page(page)

        sleep rand(1..@timeout)
      end
    end

    private

    attr_accessor :inserted_albums, :error_albums

    # rubocop:disable Security/Open
    def get_page(url)
      Nokogiri::HTML(open(url))
    end
    # rubocop:enable Security/Open

    def get_albums(page)
      page.css('.review')
    end

    # rubocop:disable Metrics/AbcSize
    def download_album(album_node)
      album = Album.new
      begin
        artist_name = album_node.css('.artist-list li').text
        album.artist = Artist.find_by(name: artist_name)
        album.artist ||= Artist.create(name: artist_name)

        album.name = album_node.css('.review__title-album').text

        return false unless Album.where(artist: album.artist, name: album.name).count.zero?

        album.thumbnail = album_node.css('.artwork img').attr('src').value
        album.link = "https://pitchfork.com#{album_node.css('.review__link').attr('href')}"

        pub_date = album_node.css('.pub-date').text
        album.release_date = if pub_date.ends_with?('ago')
                               Date.current
                             else
                               Date.strptime(album_node.css('.pub-date').text, '%B %d %Y')
                             end

        download_review_details!(album)

        album.save!

        WistfulIndie::Twitter::ScreenNameAssigner.new(album.artist).assign

        inserted_albums << album
      rescue StandardError => e
        puts "Failed because of #{e.inspect}"
        Rollbar.error(e, 'Failed to download Best New Album', artist: artist.try(:name), album: album.name)
        error_albums << album if album.name
      end
    end
    # rubocop:enable Metrics/AbcSize

    def download_review_details!(album)
      review_page = get_page(album.link)
      album.rating = review_page.css('.score').text.strip
      album.image = review_page.css('.single-album-tombstone__art img').attr('src').value
      album.review_blurb = review_page.css('[name="og:description"]')
                                      .attr('content')
                                      .value.encode('iso-8859-1').force_encoding('utf-8')
    end

    def get_next_page(page)
      next_link = page.css('.next-container .next')
      if next_link.size.zero?
        nil
      else
        get_page("https://pitchfork.com#{next_link.attr('href')}")
      end
    end
  end
end
