require_relative 'parser'
require 'open-uri'

module Lyrics
  class Finder
    def self.find(track)
      new(track).find
    end

    def initialize(track, lyrics_parser: Lyrics::Parser)
      @track = track
      @lyrics_parser = lyrics_parser
    end

    def find
      return unless genius_track
      doc = Nokogiri::HTML(OpenURI.open_uri(genius_track.url))
      text = doc.css('.lyrics').text
      parse_lyrics(text)
    end

    private

    def parse_lyrics(text)
      @lyrics_parser.parse(text)
    end

    def genius_track
      return @genius_track if @genius_track
      results = Genius::Song.search(@track.name)
      @genius_track = results.detect do |result|
        result.primary_artist.name == @track.artist
      end
    end
  end
end
