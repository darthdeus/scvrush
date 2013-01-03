class PasswordReset

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def reset_password
    user.generate_token(:password_reset_token)
    user.password_reset_sent_at = Time.zone.now
    user.save!
  end

end
