class AlbumJsonDecorator

  # Initialize decorator far an array of albums
  # @param [Array<album>] albums array to decorator
  def initialize(albums)
    @albums = albums
  end

  # Returns json for a anniversary for a group of albums
  # @returns [String] json string for albums's release date anniversaries
  def to_api_json
    Jbuilder.encode do |json|

      json.albums do
        json.array! @albums do |album|
          json.(album, :name, :artist, :uuid)
          json.set!(:thumbnail_url, album.image || album.thumbnail)
          json.set!(:release_date, album.release_date.in_time_zone.to_i)
          json.set!(:release_date_string, album.release_date.to_s)
          json.set!(:age, album.anniversary.count)
          json.set!(:day_of_week, album.anniversary.current.strftime("%A"))
          json.set!(:anniversary, album.anniversary.current.in_time_zone.to_i)
          json.set!(:anniversary_string, album.anniversary.current.to_s)
          json.set!(:review_link, album.link)
          json.set!(:rating, album.rating)
          json.set!(:link, "/#{WeeklyAnniversaries::API_VERSION}/albums/#{album.slug}")
        end
      end
    end
  end

end
