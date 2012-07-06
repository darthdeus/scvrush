class Match < ActiveRecord::Base
  has_many :games
  belongs_to :round

  belongs_to :player1, class_name: "User", foreign_key: "player1"
  belongs_to :player2, class_name: "User", foreign_key: "player2"

  attr_accessible :bo, :player1, :player2, :round

  validates_presence_of :bo, :round, :player1, :player2
end
