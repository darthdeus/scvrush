class UserAuthenticator

  def initialize(user)
    @user = user
  end

  def authenticate(password)
    return false unless @user

    hash = BCrypt::Engine.hash_secret(password, @user.password_salt)
    @user.password_hash == hash ? @user : false
  end

end

