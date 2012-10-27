# Simulate a user if there isn't one for cleaner view
class GuestUser
  def registered_for?(tournament)
    false
  end

  def checked_in?(tournament)
    false
  end

  def has_signup?(tournament)
    false
  end

  def id
    nil
  end
end

