class TournamentDecorator < Draper::Decorator
  delegate_all
  decorates :tournament

  delegate :as_json, to: :model

  def link_to_self
    h.link_to tournament.name, tournament
  end

  def link_with_image
    h.link_to tournament do
      h.image_tag tournament.image_name
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

  def checked_players
    @players ||= UserDecorator.decorate(tournament.checked_players)
  end

  def race_count(race)
    self.registered_players.select { |player| player.race == race }.size
  end

  def has_players?
    self.registered_players.size > 0
  end

  def start_time
    self.tournament.starts_at
  end

  def checkin_time
    self.start_time - 60.minutes
  end

  def start_at
    h.distance_of_time_in_words_to_now self.tournament.starts_at
  end

  def checkin_at
    h.distance_of_time_in_words_to_now(self.tournament.starts_at - 60.minutes)
  end

  # Checks if the user can admin the tournament
  def has_admin?(user)
    ability = Ability.new(user)
    ability.can? :manage, Tournament
  end

  def action_buttons
    h.content_tag :div, class: "btn-group" do
      edit_icon = h.bootstrap_icon('icon-edit', 'edit')
      content = h.link_to edit_icon, h.edit_polymorphic_path([:admin, tournament]), class: "btn btn-mini"

      icon = h.bootstrap_icon('icon-remove', 'delete')
      content << h.link_to(h.polymorphic_path([:admin, tournament]), method: :delete, class: "btn btn-mini", data: { confirm: "Are you sure?" }) { icon }
      content << h.link_to("signups", h.admin_tournament_signups_path(tournament),    class: "btn btn-mini", style: "height: 15px;")

      content.html_safe
    end
  end

end
