require 'spec_helper'

describe PagesController do
  it "has a under_construction page" do
    get :show, :id => "under_construction"    
    response.should be_success    
  end

end
