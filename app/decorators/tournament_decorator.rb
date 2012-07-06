class TournamentDecorator < Draper::Base
  decorates :tournament

  def random_count
    self.race_count("Random")
  end

  def protoss_count
    self.race_count("Protoss")
  end

  def terran_count
    self.race_count("Terran")
  end

  def zerg_count
    self.race_count("Zerg")
  end

  def registered_players
    @players ||= UserDecorator.decorate(tournament.registered_players)
  end

  def race_count(race)
    self.registered_players.select { |player| player.race == race }.size
  end

  def has_players?
    self.registered_players.size > 0
  end

  def start_at
    h.distance_of_time_in_words_to_now self.tournament.starts_at
  end

  def checkin_at
    h.distance_of_time_in_words_to_now(self.tournament.starts_at - 30.minutes)
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"),
  #                   :class => 'timestamp'
  #   end
end
