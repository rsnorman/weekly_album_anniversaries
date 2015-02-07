class AlbumAnniversariesJsonDecorator

  # Initialize decorator far an array of albums
  # @param [Array<Person>] albums array to decorator
  def initialize(albums)
    @albums = albums
  end

  # Returns json for a anniversary for a group of albums
  # @returns [String] json string for albums's release date anniversaries
  def to_api_json
    Jbuilder.encode do |json|
      json.array! @albums do |album|
        json.(album, :name, :artist, :uuid)
        json.set!(:thumbnail_url, album.thumbnail)
        json.set!(:release_date, album.release_date.in_time_zone.to_i)
        json.set!(:release_date_string, album.release_date.to_s)
        json.set!(:age, album.anniversary.count)
        json.set!(:day_of_week, album.anniversary.current.strftime("%A"))
        json.set!(:anniversary, album.anniversary.current.in_time_zone.to_i)
        json.set!(:anniversary_string, album.anniversary.current.to_s)
        json.set!(:link, "/#{WeeklyAnniversaries::API_VERSION}/albums/#{album.uuid}")
      end
    end
  end

end