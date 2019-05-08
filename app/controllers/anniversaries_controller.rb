# frozen_string_literal: true

# Controller for listing weekly anniversaries
class AnniversariesController < ApplicationController
  # Returns a list of all the anniversary for the current week
  def index
    render json: api_json_for_anniversaries
  end

  private

  def anniversaries
    @anniversaries ||=
      WeeklyAnniversaryQuery.new(Album.all.includes(:artist), week).find_all
  end

  def week
    if params[:week_number].nil?
      Week.current
    else
      Week.from_week_number(params[:week_number].to_i)
    end
  end

  def api_json_for_anniversaries
    cache(weekly_album_json_cache_key) do
      AlbumAnniversariesJsonDecorator.new(anniversaries, week).to_api_json
    end
  end

  def weekly_album_json_cache_key
    count          = anniversaries.count
    max_updated_at = anniversaries.max_by(&:updated_at)
    "anniversaries-json/all-#{count}-#{max_updated_at}-#{week.number}"
  end
end
