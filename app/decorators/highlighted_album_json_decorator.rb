# frozen_string_literal: true

class HighlightedAlbumJsonDecorator
  # Initialize decorator far an array of albums
  # @param [Array<album>] albums array to decorator
  def initialize(highlighted_album)
    @highlighted_album = highlighted_album
    @week = Week.new(@highlighted_album.anniversary.current)
    @albums = WeeklyAnniversaryQuery.new(Album.all, @week).find_all
    @albums = @albums.reject { |album| album == @highlighted_album }
  end

  # Returns json for a anniversary for a group of albums
  # @returns [String] json string for albums's release date anniversaries
  def to_api_json
    Jbuilder.encode do |json|
      highlighted_album_json(json)
      week_json(json)
      albums_json(json)
    end
  end

  private

  def highlighted_album_json(json)
    json.highlighted_album do
      json.call(@highlighted_album, :name, :uuid)
      json.set!(:artist, @highlighted_album.artist.name)
      json.set!(:thumbnail_url, @highlighted_album.image || @highlighted_album.thumbnail)
      json.set!(:release_date, @highlighted_album.release_date.in_time_zone.to_i)
      json.set!(:release_date_string, @highlighted_album.release_date.to_s)
      json.set!(:age, @highlighted_album.anniversary.count)
      json.set!(:day_of_week, @highlighted_album.anniversary.current.strftime('%A'))
      json.set!(:anniversary, @highlighted_album.anniversary.current.in_time_zone.to_i)
      json.set!(:anniversary_string, @highlighted_album.anniversary.current.to_s)
      json.set!(:review_link, @highlighted_album.link)
      json.set!(:rating, @highlighted_album.rating)
      json.set!(:review_blurb, @highlighted_album.review_blurb.gsub('...', '…').chomp('.'))
      json.set!(:link, "/#{WeeklyAnniversaries::API_VERSION}/albums/#{@highlighted_album.slug}")
    end
  end

  def week_json(json)
    json.set!(:week_start, @week.start.in_time_zone.to_i)
    json.set!(:week_end, @week.end.in_time_zone.to_i)
    json.set!(:week_number, @week.number)
  end

  def albums_json(json)
    json.albums do
      json.array! @albums do |album|
        json.call(album, :name, :uuid)
        json.set!(:artist, album.artist.name)
        json.set!(:thumbnail_url, album.image || album.thumbnail)
        json.set!(:release_date, album.release_date.in_time_zone.to_i)
        json.set!(:release_date_string, album.release_date.to_s)
        json.set!(:age, album.anniversary.count)
        json.set!(:day_of_week, album.anniversary.current.strftime('%A'))
        json.set!(:anniversary, album.anniversary.current.in_time_zone.to_i)
        json.set!(:anniversary_string, album.anniversary.current.to_s)
        json.set!(:review_link, album.link)
        json.set!(:rating, album.rating)
        json.set!(:link, "/albums/#{album.slug}")
      end
    end
  end
end
