class HighlightedAlbumJsonDecorator

  # Initialize decorator far an array of albums
  # @param [Array<album>] albums array to decorator
  def initialize(highlighted_album)
    @highlighted_album = highlighted_album
    @week = Week.new(@highlighted_album.anniversary.current)
    @albums = WeeklyAnniversaryQuery.new(Album.all, @week).find_all
    @albums = @albums.select { |album| album != @highlighted_album}
  end

  # Returns json for a anniversary for a group of albums
  # @returns [String] json string for albums's release date anniversaries
  def to_api_json
    Jbuilder.encode do |json|
      json.highlighted_album do
        json.(@highlighted_album, :name, :artist, :uuid)
        json.set!(:thumbnail_url, @highlighted_album.image || @highlighted_album.thumbnail)
        json.set!(:release_date, @highlighted_album.release_date.in_time_zone.to_i)
        json.set!(:release_date_string, @highlighted_album.release_date.to_s)
        json.set!(:age, @highlighted_album.anniversary.count)
        json.set!(:day_of_week, @highlighted_album.anniversary.current.strftime("%A"))
        json.set!(:anniversary, @highlighted_album.anniversary.current.in_time_zone.to_i)
        json.set!(:anniversary_string, @highlighted_album.anniversary.current.to_s)
        json.set!(:review_link, @highlighted_album.link)
        json.set!(:rating, @highlighted_album.rating)
        json.set!(:review_blurb, @highlighted_album.review_blurb.chomp('.'))
        json.set!(:link, "/#{WeeklyAnniversaries::API_VERSION}/albums/#{@highlighted_album.slug}")
      end

      json.set!(:week_start, @week.start.in_time_zone.to_i)
      json.set!(:week_end, @week.end.in_time_zone.to_i)
      json.set!(:week_number, @week.number)

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
