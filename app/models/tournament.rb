class Tournament < ActiveRecord::Base
  has_many :signups, dependent: :destroy
  has_many :users, through: :signups

  belongs_to :post
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'

  validates :name, presence: true
  validates :starts_at, presence: true

  attr_accessible :name, :starts_at

  scope :recent, order('starts_at DESC').limit(5)
  scope :upcoming, lambda { where(['starts_at > ?', Time.now]).first(2) }

  before_save :expire_sidebar_cache

  def expire_sidebar_cache
    # TODO - do this in a better way
    Rails.cache.delete('views/coaches')
    Rails.cache.delete('views/recent_posts')
    true
  end

  def signup_open?
    self.starts_at > 30.minutes.from_now
  end

  def checkin_open?
    self.starts_at < 30.minutes.from_now && self.starts_at > Time.now
  end

  def unregister(user)
    self.signups.where(user_id: user.id).first.destroy
  end

  def set_winner(winner)
    self.winner = winner
    self.save!
    winner.won_tournament!
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  # return random tournament info for test purposes
  def self.random_info
    [
      { matches: [
        { player1: "ham", player2: "burger" },
        { player1: "jack", player2: "john" },
        { player1: "kara", player2: "tiara" },
        { player1: "tara", player2: "lara" } ]
    }, {
      matches: [
        { player1: "ham", player2: "jack" },
        { player1: "kara", player2: "lara" } ]
    }, { matches: [ { player1: "ham", player2: "kara" } ] }
    ]
  end
end
