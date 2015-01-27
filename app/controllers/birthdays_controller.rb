class BirthdaysController < ApplicationController
  def index
    render :json => birthdays.find_all
  end

  private

  def birthdays
    @query ||= WeeklyBirthdayQuery.new
  end
end