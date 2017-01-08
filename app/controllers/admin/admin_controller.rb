module Admin
  # Base admin controller
  class AdminController < ApplicationController
    before_action :validate_admin, except: :login

    layout :admin_layout

    def login
      if valid_admin_user?
        session[:admin] = true
        redirect_to '/admin'
      else
        flash[:error] = 'Invalid password'
      end
    end

    private

    def validate_admin
      return if admin_user?
      if request.format.html?
        redirect_to '/admin/login'
      else
        render status: 401
      end
    end

    def admin_user?
      session[:admin].present?
    end

    def admin_layout
      'admin'
    end

    def valid_admin_user?
      return true if admin_user?
      return false unless params[:admin_password]
      return false unless params[:admin_email]
      params[:admin_email] == ENV['ADMIN_EMAIL'] &&
        params[:admin_password] == ENV['ADMIN_PASSWORD']
    end
  end
end
