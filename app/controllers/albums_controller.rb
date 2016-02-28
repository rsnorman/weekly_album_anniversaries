# Controller for listing albums
class AlbumsController < ApplicationController

  # Returns a list of all the anniversary for the current week
  def index
    render json: api_json_for(matching_albums)
  end

  private

  def api_json_for(albums)
    decorater = AlbumJsonDecorator.new(albums)
    decorater.to_api_json
  end

  def matching_albums
    AlbumSearch.new.search(params[:query])
  end

end
