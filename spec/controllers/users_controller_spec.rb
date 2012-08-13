require 'spec_helper'

describe UsersController do

  it "redirects to new on index" do
    # in case users makes a mistake and refreshes the page after validation fails
    get :index
    response.should redirect_to(new_user_path)
  end
end
