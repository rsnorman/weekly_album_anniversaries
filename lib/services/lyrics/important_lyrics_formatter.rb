module Lyrics
  class ImportantLyricsFormatter
    START_LAST_LINE_SIZE = 4
    DEFAULT_MAX_LYRIC_TEXT_SIZE = 160

    def initialize(lyric_lines, author:, max_size: DEFAULT_MAX_LYRIC_TEXT_SIZE)
      @lyric_lines = lyric_lines
      @author = author
      @max_size = max_size
    end

    def format
      return if @lyric_lines.empty?

      important_lyrics_lines, important_lyrics = START_LAST_LINE_SIZE, nil

      while !important_lyrics || important_lyrics.size > @max_size
        important_lyrics = last_lines(important_lyrics_lines)
        important_lyrics_lines -= 1
      end

      return if important_lyrics_lines <= 0
      important_lyrics
    end

    private

    def last_lines(pos_from_end)
      last_lines = @lyric_lines.reverse.uniq[0..(pos_from_end - 1)].reverse
      "#{last_lines.join("\n")}\n- #{@author}"
    end
  end
end
