class Admin::UsersController < ApplicationController
  layout "single"

  def index
    @users = User.first(50)
  end
end
