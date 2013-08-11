class AuthenticatedController < ApplicationController
  before_filter :login_or_trial
end
