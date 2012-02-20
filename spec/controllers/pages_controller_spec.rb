require 'spec_helper'

describe PagesController do

  specify :show do
    get :show, id: 'staff'
    response.should be_success
    response.should render_template 'pages/staff'
  end
end
