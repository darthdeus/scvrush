class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_path, :notice => "An email has been sent with instructions how you can reset your password. It might take a couple of minutes before you receive the email, please don't forget to check your spam folder."
    else
      redirect_to signup_path, :notice => "The user with given email doesn't exist. It is possible we lost your username during the data transfer, please sign up again - you can use the exact same username you had before."
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset! You can now log in."
    else
      render :edit
    end
  end
end
