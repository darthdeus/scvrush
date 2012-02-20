require 'spec_helper'

describe 'Authorization' do
  context "regular user" do
    before do
      @user = create(:user, password: 'secret')
      post sessions_path, username: @user.username, password: 'secret'
    end

    it "can't publish posts" do
      get new_post_path
      response.should redirect_to(root_path)
    end

  end

end