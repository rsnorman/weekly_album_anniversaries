# Controller for listing weekly anniversaries
class AnniversariesController < ApplicationController

  # Returns a list of all the anniversary for the current week
  def index
    render :json => api_json_for(anniversaries.find_all)
  end

  private

  def anniversaries
    @query ||= WeeklyAnniversaryQuery.new(Album.all)
  end

  def api_json_for(albums)
    decorater = AlbumAnniversariesJsonDecorator.new(albums)
    decorater.to_api_json
  end

end