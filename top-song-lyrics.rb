album = Album.all[16]
album = OpenStruct.new(name: 'Crazysexycool', artist: OpenStruct.new(name: 'TLC'))
class LyricsParser
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
    lines.select { |line| !line.blank? }
  end

  def remove_song_structure_notes(lines)
    lines.select { |line| !(line =~ /[\[|{].*[\]|}]/) }
  end

  def remove_parens_wrapping_lines(lines)
    lines.map { |line| line.gsub(/^\((.*)\)$/, '\1') }
  end
end




def get_lyrics(album)
  puts "Finding top Spotify track for #{album.name}"
  top_track = TopAlbumTrack.new(album: album).top
  if top_track
    lyrics = LyricsFinder.find(OpenStruct.new(name: top_track.name, artist: album.artist.name))
    if lyrics
      important_lyrics = ImportantLyricsFormatter.new(lyrics, author: album.artist.name).format
      unless important_lyrics
        return "No lyrics could be found for #{genius_track.title} by #{album.artist.name}"
      end
      important_lyrics
    else
      return "No genius track could be found for #{top_track.name} by #{album.artist.name}"
    end
  else
    return "No spotify top track could be found on #{album.artist.name}'s \"#{album.name}\""
  end
end

def get_lyrics(album)
  require 'open-uri'
  puts "Finding top Spotify track for #{album.name}"
  top_track = TopAlbumTrack.new(album: album).top

  if top_track
    puts "Finding Genius track for #{top_track.name}"

    results = Genius::Song.search(top_track.name)
    genius_track = results.detect { |r| r.primary_artist.name == album.artist.name }

    if genius_track
      puts "Find important Genius lyrics for #{genius_track.title}"
      doc = Nokogiri::HTML(open(genius_track.url))
      lines = doc.css('.lyrics').text.split("\n")
      lines = lines.map(&:strip).select { |line| !line.blank? }.select { |line| !(line =~ /[\[|{].*[\]|}]/) }
      lines = lines.map { |line| line.gsub(/^\((.*)\)$/, '\1') }

      important_lyrics_lines = 4
      important_lyrics = nil

      while !important_lyrics || important_lyrics.size > 160
        last_lines = lines.reverse.uniq[0..(important_lyrics_lines - 1)].reverse
        important_lyrics = "#{last_lines.join("\n")}\n- #{album.artist.name}"
        important_lyrics_lines -= 1
      end

      if important_lyrics_lines.zero? || lines.size.zero?
        return "No lyrics could be found for #{genius_track.title}"
      end

    else
      return "No genius track could be found for #{top_track.name}"
    end
  else
    return "No spotify top track could be found on #{album.artist.name}'s \"#{album.name}\""
  end

  important_lyrics
end

get_lyrics(OpenStruct.new(name: 'Crazysexycool', artist: OpenStruct.new(name: 'TLC')))
