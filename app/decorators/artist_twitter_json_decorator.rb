# frozen_string_literal: true

class ArtistTwitterJsonDecorator
  # Initialize decorator far an array of artists
  # @param [Array<artist>] artists array to decorator
  def initialize(artists)
    @artists = artists
               .select('*, case when twitter_screen_name is null then 1 else 0 end as rank')
               .order('rank DESC, name ASC')
  end

  # Returns json for artists
  # @returns [String] json string for artists
  def to_api_json
    Jbuilder.encode do |json|
      json.artists do
        json.array! @artists do |artist|
          json.call(artist, :name, :uuid, :twitter_screen_name)
          json.twitter_screen_names do
            json.array! artist.potential_twitter_screen_names do |screen_name|
              json.call(screen_name, :screen_name, :strength)
            end
          end
          json.set!(:link, "/v1/admin/artists/#{artist.id}")
        end
      end
    end
  end
end
