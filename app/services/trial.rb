class Trial

  # Create a new trial account and automatically sign the user in
  def create(session)
    username, email = Randomizer.credentials
    user = User.create!(username: username, email: email, password: SecureRandom.urlsafe_base64)
    session[:user_id] = user.id
  end

end
