class HomeController < ApplicationController
  def index
    @current_genre = Genre.first
  end
end