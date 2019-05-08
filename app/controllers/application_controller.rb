class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  around_action :set_start_of_week_day, if: :json_request?

  protected

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { status:      404,
                   status_code: "not_found",
                   message:     e.message
                 }, status: 404
  end

  private

  def set_start_of_week_day
    Week.set_start(:monday) do
      yield
    end
  end

  def json_request?
    request.format.json?
  end

end
