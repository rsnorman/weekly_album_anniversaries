class AlbumJsonDecorator
  attr_reader :album

  # Initialize decorator far an album
  # @param [Array<album>] albums array to decorator
  def initialize(album)
    @album = album
  end

  # Returns json for a anniversary for a group of albums
  # @returns [String] json string for albums's release date anniversaries
  def to_api_json
    Jbuilder.encode do |json|
      json.(album, :name, :uuid)
      json.set!(:artist, album.artist_name)
      json.set!(:thumbnail_url, album.image || album.thumbnail)
      json.set!(:release_date, album.release_date.in_time_zone.to_i)
      json.set!(:release_date_string, album.release_date.to_s)
      json.set!(:age, album.anniversary.count)
      json.set!(:day_of_week, album.anniversary.current.strftime("%A"))
      json.set!(:anniversary, album.anniversary.current.in_time_zone.to_i)
      json.set!(:anniversary_string, album.anniversary.current.to_s)
      json.set!(:review_link, album.link)
      json.set!(:rating, album.rating)
      json.set!(:generated_fun_fact_description, album.generated_fun_fact_description)
      json.set!(:fun_fact_description, album.fun_fact_description)
      json.set!(:fun_fact_source, album.fun_fact_source)
      json.set!(:link, "/albums/#{album.slug}")
      json.set!(:update, "/v1/admin/albums/#{album.id}")
    end
  end

end
