# frozen_string_literal: true

class AlbumAnniversariesJsonDecorator
  # Initialize decorator far an array of albums
  # @param [Array<album>] albums array to decorator
  def initialize(albums, week = Week.current)
    @albums = albums
    @week   = week
  end

  # Returns json for a anniversary for a group of albums
  # @returns [String] json string for albums's release date anniversaries
  def to_api_json
    Jbuilder.encode do |json|
      json.set!(:week_start, @week.start.in_time_zone.to_i)
      json.set!(:week_end, @week.end.in_time_zone.to_i)
      json.set!(:week_number, @week.number)

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
end
