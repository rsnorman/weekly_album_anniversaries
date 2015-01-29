class HomeController < ApplicationController
  def index
    @current_client = Client.first
  end
end