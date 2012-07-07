class Round < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :number, :tournament
  validates_presence_of :number, :tournament

  has_many :matches, dependent: :destroy

  def to_simple_json
    hash = { type: "match", matches: [] }
    hash[:matches] = self.matches.map do |match|
      res = {}
      res[:player1] = match.player1.username if match.player1
      res[:player2] = match.player2.username if match.player2

      res[:player1_score] = match.score_for(:player1)
      res[:player2_score] = match.score_for(:player2)

      res[:completed] = match.completed
      res
    end

    hash
  end

  # belongs_to :parent
  # has_many :children, class_name: "Round", foreign_key: "parent_id"
end
