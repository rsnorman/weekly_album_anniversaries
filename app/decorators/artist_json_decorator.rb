class ArtistJsonDecorator
  # Initialize decorator far an array of artists
  # @param [Array<artist>] artists array to decorator
  def initialize(artists)
    @artists = artists.order(twitter_screen_name: :asc)
  end

  # Returns json for artists
  # @returns [String] json string for artists
  def to_api_json
    Jbuilder.encode do |json|
      json.artists do
        json.array! @artists do |artist|
          json.(artist, :name, :uuid)
          json.twitter_screen_name artist.twitter_screen_name != 'UNKNOWN' ? artist.twitter_screen_name : nil
          json.twitter_screen_names do
            json.array! artist.potential_twitter_screen_names do |screen_name|
              json.(screen_name, :screen_name, :strength)
            end
          end
          json.set!(:link, "/v1/artists/#{artist.id}")
        end
      end
    end
  end
end
