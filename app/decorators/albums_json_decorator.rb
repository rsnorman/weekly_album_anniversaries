class AlbumsJsonDecorator

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
          json.(album, :name, :uuid)
          json.set!(:artist, album.artist_name)
          json.set!(:artist_twitter_screen_name, album.artist.twitter_screen_name ? "@#{album.artist.twitter_screen_name}" : album.artist.name)
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
  end

end
