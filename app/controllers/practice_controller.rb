class PracticeController < ApplicationController
  before_filter :require_login, except: :index

  def index
    if params[:race] || params[:server] || params[:league]
      @users = User.filtered(params).practice
    end

    gon.race   = params[:race]
    gon.server = params[:server]
    gon.league = params[:league]

    # TODO - search results should be passed back to JavaScript
    # to be highlighted in the form

    # it should also try to find users with as close league as possible,
    # but then broaden the results
  end

  def join
    @user = current_user
    @user.practice = true
    @user.save!

    redirect_to @user, notice: "You've successfully joined the Practice Buddy program!"
  end

  def quit
    @user = current_user
    @user.practice = false
    @user.save!

    redirect_to @user, notice: "You've left the Practice Buddy program, sorry to see you go."
  end
end
