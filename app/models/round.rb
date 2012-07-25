class Round < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :number, :tournament, :bo, :text, :parent

  validates_presence_of :number, :tournament

  has_many :matches, dependent: :destroy

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

  def is_first?
    self.tournament.rounds.first == self
  end

  belongs_to :parent, class_name: "Round", foreign_key: "parent_id"
  has_one    :child, class_name: "Round", foreign_key: "parent_id"
end
