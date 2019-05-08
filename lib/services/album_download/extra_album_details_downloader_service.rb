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
    rescue Exception => e
      puts "Could not download extra details for #{album.name}: #{e.inspect}"
    end

    private

    attr_accessor :album

    def page
      @page ||= Nokogiri::HTML(open(album.link))
    end
  end
end
