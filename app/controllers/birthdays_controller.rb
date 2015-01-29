# Controller for listing weekly birthdays
class BirthdaysController < ApplicationController

  # Returns a list of all the birthday for the current week
  def index
    render :json => api_json_for(birthdays.find_all)
  end

  private

  def birthdays
    @query ||= WeeklyBirthdayQuery.new(current_client.people)
  end

  def api_json_for(people)
    PersonBirthdayJsonDecorator.new(people).to_api_json
  end

end