class UserAuthenticator

  def initialize(user)
    @user = user
  end

  def authenticate(password)
    return false unless @user

    hash = BCrypt::Engine.hash_secret(password, @user.password_salt)
    @user if @user.password_hash == hash
  end

  # Generate a new API key for a user
  def generate_api_key
    @user.api_key = BCrypt::Engine.generate_salt
  end

end

