class PracticeController < ApplicationController
  before_filter :require_login

  def join
    @user = current_user
    @user.practice = true
    @user.save!

    redirect_to @user, :notice => "You've successfully joined the Practice Buddy program!"
  end

  def quit
    @user = current_user
    @user.practice = false
    @user.save!

    redirect_to @user, :notice => "You've left the Practice Buddy program, sorry to see you go."
  end
end
