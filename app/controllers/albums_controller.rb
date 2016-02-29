# Controller for listing albums
class AlbumsController < ApplicationController

  before_action :set_highlighted_album, only: :show

  # Returns a list of all the anniversary for the current week
  def index
    render json: api_json_for(matching_albums)
  end

  def show
    respond_to do |format|
      format.json do
        render json: HighlightedAlbumJsonDecorator.new(@highlighted_album).to_api_json
      end
      format.html {}
    end
  end

  private

  def api_json_for(albums)
    decorator = AlbumJsonDecorator.new(albums)
    decorator.to_api_json
  end

  def matching_albums
    AlbumSearch.new.search(params[:query])
  end

  def set_highlighted_album
    @highlighted_album = Album.find_by!(slug: params[:id])
  end

end
