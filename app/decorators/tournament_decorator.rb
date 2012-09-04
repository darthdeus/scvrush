class TournamentDecorator < Draper::Base
  decorates :tournament

  def link_to_self
    h.link_to tournament.name, tournament
  end

  def link_with_image
    images = {
      "EU_BSG" => "tournament_eu_bsg.png",
      "EU_PD"  => "tournament_eu_pd.png",
      "NA_BSG" => "tournament_na_bsg.png",
      "NA_PD"  => "tournament_na_pd.png",
      "Bronze_Week" => "tournament_bronze_week.jpg"
    }

    image = images[tournament.tournament_type] || "tournament_eu_bsg.png"

    h.link_to tournament do
      h.image_tag image
    end
  end

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

  # Checks if the user can admin the tournament
  def has_admin?(user)
    ability = Ability.new(user)
    ability.can? :manage, Tournament
  end

  def action_buttons
    h.get_action_buttons(tournament) +
    h.link_to("signups", h.admin_tournament_signups_path(tournament), class: "btn btn-mini")
  end

end
