require 'spec_helper'

describe RolesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      unauthorized?
    end
  end

end
