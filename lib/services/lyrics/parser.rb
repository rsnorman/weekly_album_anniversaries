# frozen_string_literal: true

module Lyrics
  class Parser
    def self.parse(lyrics)
      new(lyrics).parse
    end

    def initialize(lyrics)
      @lyrics = lyrics
    end

    def parse
      lines = @lyrics.split("\n").map(&:strip)
      lines = remove_blank_lines(lines)
      lines = remove_song_structure_notes(lines)
      remove_parens_wrapping_lines(lines)
    end

    private

    def remove_blank_lines(lines)
      lines.reject(&:blank?)
    end

    def remove_song_structure_notes(lines)
      lines.reject { |line| (line =~ /[\[|{].*[\]|}]/) }
    end

    def remove_parens_wrapping_lines(lines)
      lines.map { |line| line.gsub(/^\((.*)\)$/, '\1') }
    end
  end
end
