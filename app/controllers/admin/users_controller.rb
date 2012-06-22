class Admin::UsersController < ApplicationController
  layout "single"

  def index
    @users = User.all
  end
end
