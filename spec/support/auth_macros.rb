module AuthMacros

  def login(role = nil)
    user = create(:user)
    user.grant role if role
    session[:user_id] = user.id
  end

  def unauthorized?
    flash.should_not be_nil
    response.should be_redirect
    flash[:error].should match("You are not authorized")
  end

end