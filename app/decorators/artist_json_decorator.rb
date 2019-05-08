# frozen_string_literal: true

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
          json.call(artist, :name, :uuid, :twitter_screen_name)
          json.albums do
            json.array! artist.albums do |album|
              json.call(album, :name, :release_date, :thumbnail, :uuid, :rating, :review_blurb)
            end
          end
        end
      end
    end
  end
end
