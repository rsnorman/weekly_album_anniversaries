require './lib/wistful_indie/twitter/user_finder'

class ArtistJsonDecorator
  # Initialize decorator far an array of artists
  # @param [Array<artist>] artists array to decorator
  def initialize(artists)
    @artists = artists
  end

  # Returns json for artists
  # @returns [String] json string for artists
  def to_api_json
    Jbuilder.encode do |json|
      json.artists do
        json.array! @artists do |artist|
          json.(artist, :name, :twitter_screen_name, :uuid)
          json.twitter_screen_names do
            json.array! finder.all_verified_for_artist(artist.name)
          end
          json.set!(:link, "/v1/artists/#{artist.id}")
        end
      end
    end
  end

end
