module Admin
  class AdminController < ApplicationController

    layout "admin"

    before_filter :require_admin

    def require_admin
      if !logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to main_app.root_url
      elsif !current_user.has_role?(:admin)
        logger.warn "Access denied for #{current_user} with role '#{current_user.roles_name.join(', ')}'"
        flash[:error] = "Access denied! You are not authorized to do this."
        redirect_back_or_root
      end
    end


    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end


  end
end
