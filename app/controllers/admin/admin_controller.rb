module Admin
  class AdminController < ApplicationController

    layout "admin"
    before_filter :require_login
    before_filter :require_admin


    def require_role(role)
      if !current_user.has_role?(role)
        logger.warn "Access denied for #{current_user} with role '#{current_user.roles_name.join(', ')}'"
        flash[:error] = "Access denied! You are not authorized to do this."
        redirect_back_or_root
      end
    end

    def require_admin
      require_role(:admin)
    end

    def redirect_back_or_root
      if request.env["HTTP_REFERER"] && !request.xhr?
        redirect_to :back
      else
        redirect_to root_path
      end
    end

  end
end
