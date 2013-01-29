class Trial

  def attributes
    username, email = Randomizer.credentials
    {
      username: username,
      email: email,
      password: SecureRandom.urlsafe_base64,
      expires_at: 2.days.from_now
    }
  end

  # Create a new trial account and automatically sign the user in
  def create(session)
    user = User.create!(self.attributes)
    session[:user_id] = user.id
  end

end
