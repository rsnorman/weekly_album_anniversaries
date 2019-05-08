# frozen_string_literal: true

module Admin
  # Controller for listing albums
  class AlbumsController < Admin::AdminController
    before_action :set_albums, only: :index
    before_action :set_album, only: :update

    def index
      respond_to do |format|
        format.html {}
        format.json { render json: api_json_for_albums(@albums) }
      end
    end

    def update
      @album.update(album_attributes)

      respond_to do |format|
        format.html { head :ok }
        format.json { render json: api_json_for_album(@album.resource) }
      end
    end

    private

    def api_json_for_albums(albums)
      albums_decorator(albums).to_api_json
    end

    def api_json_for_album(album)
      album_decorator(album).to_api_json
    end

    def set_albums
      @albums = WeeklyAnniversaryQuery.new(Album.all.includes(:artist), Week.current).find_all
      @albums += WeeklyAnniversaryQuery.new(Album.all.includes(:artist), Week.current.next).find_all
    end

    def set_album
      @album = AlbumUpdater.new(Album.find(params[:id]))
    end

    def album_attributes
      params.require(:album).permit(:fun_fact_description, :fun_fact_source)
    end

    def albums_decorator(albums)
      AlbumsJsonDecorator.new(albums)
    end

    def album_decorator(album)
      AlbumJsonDecorator.new(album)
    end
  end
end
