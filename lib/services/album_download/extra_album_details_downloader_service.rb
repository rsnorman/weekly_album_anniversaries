# frozen_string_literal: true

module AlbumDownload
  class ExtraAlbumDetailsDownloaderService
    require 'open-uri'

    def initialize(album)
      @album = album
    end

    def download
      album.image ||= page.css('.artwork img').attr('src').value
      album.review_blurb ||= page.css('meta[property=\'og:description\']').attr('content').value
      album.save!
    rescue StandardError => e
      Rollbar.error(e, album: album.name, artist: album.artist.name)
    end

    private

    attr_accessor :album

    # rubocop:disable Security/Open
    def page
      @page ||= Nokogiri::HTML(open(album.link))
    end
    # rubocop:enable Security/Open
  end
end
