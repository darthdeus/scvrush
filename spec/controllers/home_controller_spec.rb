require 'spec_helper'

describe HomeController do
  specify :index do
    get :index
    response.should be_success
  end
end