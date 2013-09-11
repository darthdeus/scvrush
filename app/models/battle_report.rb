class BattleReport < ActiveRecord::Base
  attr_accessible :title, :content, :tournament_id
  belongs_to :tournament
  validates_presence_of :title, :content, :tournament_id

  def tournament_human_start
    tournament.starts_at.strftime("%I:%M %P %Z")
  end

  def image_name
    tournament.image_name
  end

  def signups_count
    tournament.signups.size
  end
end
