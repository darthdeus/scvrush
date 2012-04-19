class Raffle < ActiveRecord::Base
  DRAFT = 0
  OPEN = 1
  FINISHED = 2

  belongs_to :winner, class_name: "User", foreign_key: "winner_id"
  has_many :raffle_signups, dependent: :destroy
  has_many :users, through: :raffle_signups

  validates_presence_of :status
  validates_presence_of :title

  def start!
    self.status = Raffle::OPEN
  end

  def finish!
    self.status = Raffle::FINISHED
  end

  def calculate_winner
    self.winner = users.sample
    self.status = Raffle::FINISHED
    save!
    self.winner
  end

  def register(user)
    RaffleSignup.create!(raffle: self, user: user)
  end

  def is_open?
    self.status == Raffle::OPEN
  end
end
