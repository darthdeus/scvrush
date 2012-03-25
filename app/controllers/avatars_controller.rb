class AvatarsController < ApplicationController
  before_filter :require_login

  def new
    @user = current_user
  end

  def create
    @user = current_user
    @user.avatar = params[:avatar]
    if @user.save
      redirect_to action: :new, notice: "Avatar successfuly uploaded."
    else
      redirect_to action: :new, notice: "There was an error uploading your avatar. Please use only JPG or PNG image."
    end
  end

end
