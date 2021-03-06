# frozen_string_literal: true

require './lib/wistful_indie/twitter/client'

module AlbumAnniversary
  class AlbumAnniversaryTweeter
    include ActionView::Helpers::TextHelper

    def self.tweet(album)
      new(album).tweet
    end

    def initialize(album = highlighted_album)
      @album = album
    end

    def tweet
      return if album.nil?

      HighlightedAlbum.transaction do
        HighlightedAlbum.create(album: album)
        begin
          client.update_with_media(tweet_content, album_image_file)
        rescue Twitter::Error::Forbidden => e
          shorten_tweet if e.message == 'Status is over 140 characters.'
        end
      end
    ensure
      delete_album_image if album
    end

    private

    attr_reader :album

    def tweet_content(shortness_level: 0)
      content = "#{artist_possesive} \"#{album.name}\" " \
      "turns #{pluralize(album.anniversary.count, 'year')} old this week. "
      content += "http://www.wistfulindie.com/albums/#{album.slug} " if shortness_level < 2
      content + hash_tags(without_artist: shortness_level.positive?).to_s
    end

    def artist_possesive
      name = artist_name
      name[-1] == 's' ? "#{name}'" : "#{name}'s"
    end

    def artist_name
      if (screen_name = album.artist.twitter_screen_name)
        ".@#{screen_name}"
      else
        album.artist.name
      end
    end

    def hash_tags(without_artist: false)
      if without_artist
        '#indiemusic'
      else
        "#indiemusic ##{album.artist.name.gsub(/[^a-zA-Z]*/, '')}"
      end
    end

    def album_image_file
      return @album_image_file if @album_image_file

      save_album_image
      @album_image_path = File.open(album_image_path)
    end

    def save_album_image
      File.open(album_image_path, 'w', encoding: 'ascii-8bit') do |f|
        f << download_album_image
      end
    end

    def delete_album_image
      album_image_file.close
      File.unlink(album_image_file)
    end

    # rubocop:disable Security/Open
    def download_album_image
      require 'open-uri'
      open(album.image || album.thumbnail, &:read)
    end
    # rubocop:enable Security/Open

    def album_image_path
      "./tmp/#{album.slug}.jpg"
    end

    def highlighted_album
      return @highlighted_album if @highlighted_album

      @highlighted_album = WeeklyAnniversaryQuery.new(
        unhighlighted_albums
      ).find_all.detect do |album|
        album.anniversary.current == Date.current && !album.anniversary.count.zero?
      end
    end

    def unhighlighted_albums
      Album.where.not(id: HighlightedAlbum.pluck(:album_id))
    end

    def client
      WistfulIndie::Twitter::Client.client
    end

    def shorten_tweet
      client.update_with_media(tweet_content(shortness_level: 1), album_image_file)
    rescue Twitter::Error::Forbidden => e
      if e.message == 'Status is over 140 characters.'
        client.update_with_media(tweet_content(shortness_level: 2), album_image_file)
      end
    end
  end
end
