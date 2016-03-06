# Controller for listing artists
class ArtistsController < ApplicationController
  before_action :set_artists, only: :index
  before_action :set_artist, only: :update

  # Returns a list of all the anniversary for the current week
  def index
    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: api_json_for(@artists) }
    end
  end

  def update
    @artist.update(artist_attributes)
    head :ok
  end

  private

  def api_json_for(artists)
    decorator = ArtistJsonDecorator.new(artists)
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
end
