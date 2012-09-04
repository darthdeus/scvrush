class Tournament < ActiveRecord::Base
  has_many :signups, dependent: :destroy
  has_many :users, through: :signups

  has_many :rounds, order: "number DESC", dependent: :destroy
  has_many :matches, through: :rounds, order: "id"

  belongs_to :post
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  belongs_to :user

  validates :name, presence: true
  validates :starts_at, presence: true

  TYPES = %w(EU_BSG EU_PD NA_BSG NA_PD EU_Masters User Bronze_Week)

  validates :tournament_type, inclusion: TYPES
  validates :bo_preset, format: { with: /^[\d ]+$/ }

  # TODO - remove this so users can't create official tournaments
  attr_accessible :name, :starts_at, :tournament_type, :description, :admins,
    :rules, :map_info, :bo_preset, :map_preset, :visible, :channel, :admin_names

  scope :recent, order('starts_at DESC').limit(5)
  scope :upcoming, lambda { where("starts_at > ? AND tournament_type <> 'User'", Time.now).order(:starts_at) }

  def admin_names
    User.with_role(:tournament_admin, self) - User.with_role(:tournament_admin)
  end

  def admin_names=(ids)
    admin_names.each do |user|
      user.revoke :tournament_admin, self
    end

    ids.each do |id|
      user = User.find_by_id(id)
      user.grant :tournament_admin, self if user
    end
  end

  def self.types
    {
      eu_bsg:      "EU_BSG",
      eu_pd:       "EU_PD",
      na_bsg:      "NA_BSG",
      na_pd:       "NA_PD",
      eu_masters:  "EU_Masters",
      user:        "User",
      bronze_week: "Bronze_Week"
    }
  end

  def registered_players
    self.signups.includes(:user).all.select { |signup|
      [0,1].include?(signup.status) }.map(&:user)
  end

  def start
    self.starts_at = Time.now
    self.save!
  end

  # TODO - rewrite this to a scope.
  #
  # It should also be possible to do something like
  # tournament.checked_users << user,
  # but I'm not sure ... need to check that with API documentation
  def checked_players
    self.users.includes(:signups).where(signups: { status: 1 }).order(:id).all
  end

  has_many :players, class_name: "User", conditions: where(signups: { status: 1}).order(:id)

  before_save :expire_sidebar_cache
  before_save :set_default_rules

  def set_default_rules
    self.rules    = I18n.t("tournament.rules")    unless self.rules.present?
    self.map_info = I18n.t("tournament.map_info") unless self.map_info.present?
    true
  end

  def expire_sidebar_cache
    # TODO - do this in a better way
    Rails.cache.delete('views/coaches')
    Rails.cache.delete('views/recent_posts')
    true
  end

  def maps
    self.map_preset.gsub("\r", "").split("\n\n") if self.map_preset
  end

  def registration_open?
    self.starts_at > Time.now
  end

  def checkin_open?
    self.starts_at < 30.minutes.from_now && self.starts_at > Time.now
  end

  def started?
    self.starts_at < Time.now
  end

  def unregister(user)
    self.signups.where(user_id: user.id).each(&:destroy)
  end

  def signup_for(user)
    self.signups.where(user_id: user.id).first
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
