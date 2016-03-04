class ExtraAlbumDetailsDownloaderService
  require 'open-uri'

  DEFAULT_TIMEOUT = 5

  def initialize(album, options = {})
    @album = album
    @timeout = options[:timeout] || DEFAULT_TIMEOUT
  end

  def download
    album.image = page.css('.artwork img').attr('src').value
    album.review_blurb = page.css('meta[property=\'og:description\']').attr('content').value
    album.save
  end

  private

  attr_accessor :album

  def page
    @page ||= Nokogiri::HTML(open(album.link))
  end
end
