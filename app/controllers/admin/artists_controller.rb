# frozen_string_literal: true

module Admin
  # Controller for listing artists
  class ArtistsController < Admin::AdminController
    before_action :set_artists, only: :index
    before_action :set_artist, only: :update

    def index
      respond_to do |format|
        format.html {}
        format.json { render json: api_json_for(@artists) }
      end
    end

    def update
      @artist.update(artist_attributes)
      head :ok
    end

    private

    def api_json_for(_artists)
      decorator.to_api_json
    end

    def set_artists
      @artists = Artist.all
    end

    def set_artist
      @artist = Artist.find(params[:id])
    end

    def artist_attributes
      params.require(:artist).permit(:twitter_screen_name)
    end

    def decorator
      if params[:export] == 'true'
        ArtistJsonDecorator.new(@artists)
      else
        ArtistTwitterJsonDecorator.new(@artists)
      end
    end
  end
end
