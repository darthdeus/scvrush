module LoginSteps
  def login(username, password)
    visit login_path
    fill_in 'username', :with => username
    fill_in 'password', :with => password
    click_button 'Log in'        
  end
end

World(LoginSteps)