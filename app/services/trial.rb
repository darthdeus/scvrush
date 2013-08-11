class Trial

  def initial_attributes
    username, email = Randomizer.credentials
    {
      username: username,
      password: SecureRandom.urlsafe_base64,
      expires_at: 2.days.from_now
    }
  end

  # Create a new trial account and automatically sign the user in
  def create(session, ip)
    user, count = nil, 0

    begin
      attributes = initial_attributes
      attributes[:server] = guess_server(ip)

      user = User.new(attributes)
      count += 1
    end while !user.valid? && count < 3

    user.save!

    session[:user_id] = user.id
  end

  def guess_server(ip)
    server = GEOIP.country(ip).continent_code

    ["EU", "NA"].include?(server) ? server : nil

    "EU"
  end


end
