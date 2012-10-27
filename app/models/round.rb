class Round < ActiveRecord::Base
  attr_accessible :number, :tournament, :bo, :text, :parent, :child

  validates_presence_of :number, :tournament

  belongs_to :tournament

  belongs_to :parent, class_name: "Round", foreign_key: "parent_id"
  has_one    :child, class_name: "Round", foreign_key: "parent_id"
  has_many   :matches, dependent: :destroy, order: "id"

  def to_simple_json
    hash = { type: "round", matches: [] }
    hash[:number]  = self.number
    hash[:id]      = self.id

    hash[:matches] = self.matches.map do |match|
      res = {}
      res[:player1] = match.player1.bnet_info if match.player1
      res[:player2] = match.player2.bnet_info if match.player2
      res[:id] = match.id

      res[:player1_score] = match.score_for(:player1)
      res[:player2_score] = match.score_for(:player2)

      res[:completed] = match.completed
      res
    end

    hash
  end

  def next
    parent
  end

  def next?
    !!self.next
  end

  # Return a match with given seed
  def match_with_seed(seed)
    self.matches.order(:id).where(seed: seed).first
  end

  def is_first?
    self.tournament.rounds.first == self
  end

end
