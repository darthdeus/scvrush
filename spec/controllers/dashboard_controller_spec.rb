require 'spec_helper'

describe DashboardController do
  it "is only available for admin users" do
    login
    get :index
    unauthorized?
  end
end
