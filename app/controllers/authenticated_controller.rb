class AuthenticatedController < ApplicationController
  before_filter :login_or_trial

  def login_or_trial
    unless logged_in?
      user = Trial.new.create(session, request.remote_ip)
    end
  end

end
