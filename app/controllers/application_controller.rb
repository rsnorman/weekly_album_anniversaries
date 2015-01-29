class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  around_filter :set_start_of_week_day, if: :json_request?

  protected

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { status:      404,
                   status_code: "not_found",
                   message:     e.message
                 }, status: 404
  end

  # Gets the current client from HTTP_UUID header
  # Raises error if one cannot be found
  def current_client
    @current_client ||=
      begin
        uuid = env["HTTP_UUID"] || session["HTTP_UUID"]
        @current_client = Client.where(uuid: uuid).first

        if @current_client.nil?
          raise(
            ActiveRecord::RecordNotFound,
            "Couldn't find client with id => #{uuid}"
          )
        end

        @current_client
      end
  end

  private

  def set_start_of_week_day
    Week.set_start(current_client.week_start_preference) do
      yield
    end
  end

  def json_request?
    request.format.json?
  end

end
