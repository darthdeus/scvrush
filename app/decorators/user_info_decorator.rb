class UserInfoDecorator < Draper::Decorator

  def as_json(options = {})
    data = {
      race:     model.race,
      league:   model.league,
      friends:  model.friends
    }
  end

end
