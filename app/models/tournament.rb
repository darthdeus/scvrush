class Tournament < ActiveRecord::Base
  has_many :signups, dependent: :destroy
  has_many :users, through: :signups

  has_many :rounds, order: "number DESC", dependent: :destroy
  has_many :matches, through: :rounds, order: "id"

  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  belongs_to :user

  validates :name, presence: true
  validates :starts_at, presence: true

  TYPE_USER = "User"
  TYPES = %w(EU_BSG EU_BS EU_GP EU_D EU_DM EU_PD EU_Masters NA_Friday NA_BSG NA_PD NA_M User Bronze_Week)
  REGIONS = %w(EU NA KR SEA)
  MAX_PLAYERS = %w(4 8 16 32 64 128)
  LEAGUES = %w(BRONZE SILVER GOLD PLATINUM DIAMOND MASTER)

  validates :tournament_type, inclusion: TYPES
  validates :bo_preset, format: { with: /\A[\d ]+\z/ }

  attr_accessible :name, :starts_at, :tournament_type, :description,
                  :rules, :map_info, :bo_preset, :map_preset, :visible,
                  :channel, :admin_names, :logo, :region, :max_players, :leagues

  scope :in_range, ->(from, to) { where("starts_at > ? AND starts_at < ?", from, to) }
  scope :ordered, -> { order("starts_at DESC") }
  scope :recent, -> { order("starts_at DESC").limit(5) }
  scope :upcoming, -> { where("starts_at > ? AND tournament_type <> 'User'", Time.now).order(:starts_at) }
  scope :past, -> { where("starts_at < ?", Time.zone.now) }
  scope :official, -> { where("tournament_type <> ?", TYPE_USER) }

  default_scope -> { order("starts_at DESC") }

  #mounting the logo
  mount_uploader :logo, LogoUploader

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,       index: :not_analyzed
    indexes :name,     analyzer: "snowball", boost: 100
  end

  def to_indexed_json
    to_json(only: [:name])
  end

  def admins
    User.with_role(:tournament_admin, self) - User.with_role(:tournament_admin)
  end

  def admins=(users)
    admins.each { |user| user.revoke(:tournament_admin, self) }
    users.each  { |user| user.grant(:tournament_admin, self) }
  end

  def self.types
    {
      eu_bsg:      "EU_BSG",
      eu_pd:       "EU_PD",
      eu_dm:       "EU_DM",
      na_bsg:      "NA_BSG",
      na_pd:       "NA_PD",
      na_m:        "NA_M",
      eu_masters:  "EU_Masters",
      user:        "User",
      bronze_week: "Bronze_Week"
    }
  end

  def image_name
    images = {
      "EU_BSG"      => "tournament_eu_bsg.png",
      "EU_BS"       => "tournament_eu_bs.png",
      "EU_PD"       => "tournament_eu_pd.png",
      "EU_DM"       => "tournament_eu_dm.png",
      "EU_GP"       => "tournament_eu_gp.png",
      "EU_D"        => "tournament_eu_d.jpg",
      "NA_BSG"      => "tournament_na_bsg.png",
      "NA_PD"       => "tournament_na_pd.png",
      "NA_M"        => "tournament_na_m.png",
      "Bronze_Week" => "tournament_bronze_week.jpg",
      "NA_Friday"   => "tournament_na_friday.png"
    }

    images[tournament_type] || "post_default_image.png"
  end

  def registered_players
    self.signups.includes(:user).all.select { |signup|
      [0,1].include?(signup.status) }.map(&:user)
  end

  def start
    self.starts_at = Time.now
    self.save!
  end

  def empty?
    signups.size == 0
  end

  # TODO - rewrite this to a scope.
  #
  # It should also be possible to do something like
  # tournament.checked_users << user,
  # but I'm not sure ... need to check that with API documentation
  def checked_players
    self.users.includes(:signups).where(signups: { status: 1 }).order(:id).all
  end

  has_many :users, through: :signups
  #conditions: where(signups: { status: 1 }).order(:id),

  before_save :set_default_rules

  def set_default_rules
    self.rules    = I18n.t("tournament.rules")    unless self.rules.present?
    self.map_info = I18n.t("tournament.map_info") unless self.map_info.present?
    true
  end

  def registration_open?
    self.starts_at > Time.now
  end

  def checkin_open?
    now = Time.zone.now
    now > (starts_at - 1.hour) && now < starts_at
  end

  def started?
    self.starts_at < Time.now
  end

  def unregister(user)
    self.signups.where(user_id: user.id).each(&:destroy)
    Tournament.reset_counters(self.id, :signups)
  end

  def signup_for(user)
    self.signups.where(user_id: user.id).first
  end

  def set_winner(winner)
    self.winner = winner
    self.save!
    winner.won_tournament!
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

  def self.factory(params, user)
    tournament = new
    tournament.name = params[:name]
    tournament.starts_at = params[:starts_at]
    tournament.max_players = params[:max_players]
    tournament.leagues = params[:leagues]
    tournament.region = params[:region]
    tournament.channel = params[:channel]
    tournament.description = params[:description]

    tournament.tournament_type = self.types[:user]
    tournament.user = user
    tournament.bo_preset = "1"

    tournament
  end

  def maps
    map_preset.split("\r\n\r\n") if map_preset
  end

  def check_in_all
    users.each { |u| u.check_in(self) }
  end

  def current_match_for(user)
    sorted_rounds = self.rounds.includes(:matches).order("number DESC")
    sorted_rounds.map(&:matches).flatten.select do |m|
      m.player1_id == user.id || m.player2_id == user.id
    end.last
  end

  def checked_trial_players
    self.users.includes(:signups).where(signups: { status: 1 }).where("expires_at IS NOT NULL").order(:id).all
  end

  def sorted_matches
    self.matches.where("score IS NOT NULL").order("updated_at DESC")
  end

  class DoubleRegistration < Error; end
end
