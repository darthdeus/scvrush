class Round < ActiveRecord::Base
  attr_accessible :number, :tournament, :bo, :text, :parent, :child

  validates_presence_of :number, :tournament

  belongs_to :tournament

  belongs_to :parent, class_name: "Round", foreign_key: "parent_id"
  has_one    :child, class_name: "Round", foreign_key: "parent_id"
  has_many   :matches, dependent: :destroy, order: "id"

  def next
    parent
  end

  # Return a match with given seed
  def match_with_seed(seed)
    self.matches.order(:id).where(seed: seed).first
  end

  def is_first?
    self.tournament.rounds.first == self
  end

  def human_name
    case self.number
    when 1 then "Champion"
    when 2 then "Finals"
    when 4 then "Semifinals"
    when 8 then "Quarter finals"
    else "Ro#{self.number}"
    end
  end

  def map_pool
    tournament.maps[tournament.rounds.index(self)] if tournament.maps
  end

end
