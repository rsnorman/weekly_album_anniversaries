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

  # Gets the current genre from HTTP_UUID header
  # Raises error if one cannot be found
  def current_genre
    @current_genre ||=
      begin
        uuid = env["HTTP_UUID"] || session["HTTP_UUID"]
        @current_genre = Genre.where(uuid: uuid).first

        if @current_genre.nil?
          raise(
            ActiveRecord::RecordNotFound,
            "Couldn't find genre with id => #{uuid}"
          )
        end

        @current_genre
      end
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
