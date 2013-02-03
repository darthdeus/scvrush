class UserInfoDecorator < Draper::Decorator
  decorates :user

  def as_json
    data = {
      race:     user.race,
      league:   user.league,
      friends:  user.friends
    }
  end

end
