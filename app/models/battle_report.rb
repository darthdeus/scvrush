class BattleReport < ActiveRecord::Base
  attr_accessible :title, :content, :tournament_id, :vod, :team_liquid, :next_tournament
  belongs_to :tournament
  validates_presence_of :title, :content, :tournament_id

  def tournament_human_start
    tournament.starts_at.strftime("%I:%M %P %Z")
  end

  def image_name
    tournament.image_name
  end

  def players_count
    tournament.checked_players.count
  end
end

