class Randomizer
  ADJECTIVES = %w{angry happy gosu furious enraged workoholic}

  UNITS = %w{zergling baneling ultralisk mutalisk overlord drone marine
    marauder medivac zealot stalker archon sentry carrier phoenix scv}

  def self.username
    "%s-%s-%i" % [ADJECTIVES.sample, UNITS.sample, rand() * 1000000]
  end

  def self.email_for(username)
    "#{username}@trial.scvrush.com"
  end

  def self.credentials
    username = self.username
    [username, self.email_for(username)]
  end

  def self.email
    email_for(username)
  end

end
