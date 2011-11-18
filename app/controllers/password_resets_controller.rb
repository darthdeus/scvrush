class PasswordResetsController < ApplicationController
  def new
  end

  def create
    redirect_to root_path, :notice => "Email sent with instructions to reset password"
  end
end
