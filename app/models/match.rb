class Match < ActiveRecord::Base
  has_many :games
  belongs_to :round

  belongs_to :player1, class_name: "User", foreign_key: "player1"
  belongs_to :player2, class_name: "User", foreign_key: "player2"

  attr_accessible :bo, :player1, :player2, :round, :seed

  # FIX - there is no validation for players, since the bracket is pre-populated
  # with empty matches, and then the players are seeded later.
  #
  # TODO - add automatic walkover for player1 if there is no player2
  validates_presence_of :bo, :round, :seed

  before_save :check_if_completed

  def check_if_completed
    if (player1 && !player2) || (!player1 && !player2)
      self.completed = true
    else
      self.completed = false
    end
    true
  end
end
