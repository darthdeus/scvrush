require 'spec_helper'

describe PracticeController do

  describe "routing" do

    specify :index do
      get('/practice').should           route_to('practice#index')
      post('/practice').should_not     be_routable
      get('/practice?race=Zerg').should route_to('practice#index')
    end

  end

end