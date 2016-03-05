# Controller for listing artists
class ArtistsController < ApplicationController
  before_action :set_artists, only: :index

  # Returns a list of all the anniversary for the current week
  def index
    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: api_json_for(@artists) }
    end
  end

  private

  def api_json_for(artists)
    decorator = ArtistJsonDecorator.new(artists)
    decorator.to_api_json
  end

  def set_artists
    @artists = Artist.all
  end
end
