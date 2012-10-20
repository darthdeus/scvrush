module Admin
  class AdminController < ApplicationController

    layout "admin"
    before_filter :require_login
    before_filter :require_admin
  end
end
