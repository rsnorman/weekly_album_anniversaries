require_relative '../top_song/top_album_track'
require './lib/wistful_indie/twitter/client'
require_relative 'finder'
require_relative 'important_lyrics_formatter'

module Lyrics
  # Tweets classic lyrics
  class LyricsTweeter
    def self.tweet_about(album)
      new(album: album).tweet
    end

    def initialize(album:,
                   twitter_client: WistfulIndie::Twitter::Client.client,
                   top_track_finder: TopSong::TopAlbumTrack,
                   lyrics_finder: Lyrics::Finder,
                   lyrics_formatter: Lyrics::ImportantLyricsFormatter)
      @client = twitter_client
      @album = album
      raise ArgumentError, 'Must pass an album' if @album.nil?
      @top_track_finder = top_track_finder
      @lyrics_finder = lyrics_finder
      @lyrics_formatter = lyrics_formatter
    end

    def tweet
      return unless top_track
      return unless lyrics
      puts "Tweeting top lyrics for #{artist.name} - #{top_track.name}"
      @client.update(tweet_text)
    end

    private

    def artist
      @album.artist
    end

    def top_track
      @top_track ||= @top_track_finder.top_for(@album)
    end

    def tweet_text
      important_lyrics
    end

    def lyrics
      @lyrics ||= @lyrics_finder.find(OpenStruct.new(name: @top_track.name,
                                                     artist: artist.name))
    end

    def important_lyrics
      return unless lyrics
      @important_lyrics ||= @lyrics_formatter.new(
                              lyrics, author: lyrics_author
                            ).format
    end

    def lyrics_author
      return artist.name unless twitter_account?
      "@#{artist.twitter_screen_name}"
    end

    def twitter_account?
      artist.twitter_screen_name && !artist.twitter_screen_name.length.zero?
    end
  end
end
