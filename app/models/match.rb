class ScoreValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.player1_id? || record.player2_id?
      if value.present? && value !~ /^\d:\d$/
        record.errors[attribute] << "must have a format of N:N, e.g. 3:1"
      elsif value && value == "0:0"
        record.errors[attribute] << "can't be 0:0"
      end
    end
  end
end


class Match < ActiveRecord::Base
  class UnknownPlayer < Exception; end

  has_many :games, dependent: :destroy
  belongs_to :round

  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User"

  attr_accessible :player1, :player2, :player1_id, :player2_id, :round, :seed, :score

  # FIX - there is no validation for players, since the bracket is pre-populated
  # with empty matches, and then the players are seeded later.
  #
  # TODO - add automatic walkover for player1 if there is no player2
  validates_presence_of :round, :seed

  validates :score, score: true
  # validates_format_of :score, with: /^\d:\d$/, if: lambda { |match| match.score? }

  before_save :check_if_completed

  # Set the score for a current match and advance
  # the winner to the next match
  def set_score_and_advance(user, score)
    self.set_score_for(user, score)
    next_match = self.next

    return if next_match.nil?

    if self.seed % 2 == 0
      next_match.player1 = self.winner
    else
      next_match.player2 = self.winner
    end

    next_match.save!
  end

  # Sets score for a given user
  def set_score_for(user, score)
    if user.id == player1_id
      self.score = score
    else
      self.score = score.split(":").reverse.join(":")
    end
  end

  # Checkes if the match was completed
  def check_if_completed
    if (!player1 && !player2) || (self.round.is_first? && !self.player2)
      self.completed = true
    else
      self.completed = false
    end
    true
  end

  def can_submit?
    !!(!self.winner && self.player1 && self.player2)
  end

  # Returns the winner for a given match
  def winner
    return nil unless self.score.present?

    split = self.score.split ":"

    if split[0].to_i > split[1].to_i
      self.player1
    else
      self.player2
    end
  end

  # Set score for a given player in the match
  def score_for(player)
    return nil if self.score.nil? || player.nil?

    split = self.score.split ":"
    return nil if split.empty?
    if player == :player1
      split[0].to_i
    else
      split[1].to_i
    end
  end

  # Unset the given player from the match
  def unset_player(player)
    if self.player1 == player
      self.player1 = nil
    elsif self.player2 == player
      self.player2 = nil
    elsif player.present?
      raise UnknownPlayer.new("Can't unset a player who isn't playing this match")
    end
  end

  # Unset the match score and propagate to the following match
  # to unset the winner
  def unset_score(player = nil)
    self.unset_player(player)
    winner = self.winner
    self.score = nil
    self.save
    self.next.unset_score(winner) if self.next
  end

  # Returns the opponent for a given user
  def opponent_for(user)
    self.player1_id == user.id ? self.player2 : self.player1
  end

  # Return the player who lost the match,
  # or nil if the match isn't over yet
  def loser
    return nil if self.winner.nil?
    self.opponent_for(self.winner)
  end

  # Checkes if a given user lost the match
  def loser?(user)
    !self.winner.nil? && (self.winner.id != user.id)
  end

  # Return the next following match in the next round
  # or nil if there is no followup match
  def next
    next_round = self.round.next
    next_round ? next_round.match_with_seed(self.seed / 2) : nil
  end

end

