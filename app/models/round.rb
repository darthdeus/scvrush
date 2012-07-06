class Round < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :number, :tournament
  validates_presence_of :number, :tournament

  has_many :matches

  def to_simple_json
    hash = { type: "match", matches: [] }
    hash[:matches] = self.matches.map do |match|
      res = {
        player1: match.player1.username,
      }
      res[:player2] = match.player2.username if match.player2
      res
    end

    hash
  end

  # belongs_to :parent
  # has_many :children, class_name: "Round", foreign_key: "parent_id"
end
