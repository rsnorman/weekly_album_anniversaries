# Controller for listing weekly anniversaries
class AnniversariesController < ApplicationController

  # Returns a list of all the anniversary for the current week
  def index
    render json: api_json_for(anniversaries.find_all)
  end

  private

  def anniversaries
    @query ||= WeeklyAnniversaryQuery.new(Album.all, week)
  end

  def week
    params[:week_number].nil? ?
    Week.current :
    Week.from_week_number(params[:week_number].to_i)
  end

  def api_json_for(albums)
    decorater = AlbumAnniversariesJsonDecorator.new(albums, week)
    decorater.to_api_json
  end

end
