class User < ActiveRecord::Base
  rolify
  include BattleNet
  include Player

  scope :with_bnet_info, -> { where("bnet_username IS NOT NULL AND bnet_code IS NOT NULL") }

  has_and_belongs_to_many :roles, join_table: :users_roles

  has_many :follower_followings, foreign_key: "followee_id", class_name: "Following"
  has_many :followers, through: :follower_followings, source: :follower

  has_many :followee_followings, foreign_key: "follower_id", class_name: "Following"
  has_many :followees, through: :followee_followings, source: :followee

  has_many :replies
  has_many :signups, dependent: :destroy
  has_many :tournaments, through: :signups
  has_many :won_tournaments, class_name: "Tournament", foreign_key: "winner_id"

  has_many :owned_tournaments, class_name: "Tournament", foreign_key: "user_id"

  has_many :statuses
  has_many :posts

  has_many :notifications, dependent: :destroy, order: "created_at DESC"

  attr_accessible :username, :email, :password, :password_confirmation,
                  :password_reset_token, :avatar, :race, :league, :server,
                  :favorite_player, :skype, :display_skype, :msn,
                  :display_msn, :display_email, :about, :avatar,
                  :bnet_code, :bnet_username, :twitter, :time_zone, :practice,
                  :image, :bnet_info, :expires_at, :tournament_admin

  attr_accessor :password, :validate_trial_email

  mount_uploader :avatar, AvatarUploader

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,       index: :not_analyzed
    indexes :username, analyzer: "snowball", boost: 100
    indexes :race,     analyzer: "snowball"
    indexes :league,   analyzer: "snowball", boost: 50
    indexes :server,   analyzer: "snowball", boost: 50
  end

  def to_indexed_json
    to_json(only: [:username, :race, :league, :server])
  end

  def recommended_coaches
    Coach.where("? = ANY(races)", self.race)
  end

  def recent_statuses
    statuses.order("created_at DESC").limit(5)
  end

  def suggested_posts
    race.present? ? Post.search(race, per_page: 3)  : []
  end

  # Return a user either by his username or by email.
  # Used mostly for authentication purposes.
  def self.username_or_bnet_info(query)
    where('username ILIKE ? OR bnet_username ILIKE ?', "%#{query}%", "%#{query}%")
  end

  # Return a user either by his username or by email.
  # Used mostly for authentication purposes.
  def self.with_login(login)
    where('username ILIKE ? OR email ILIKE ?', login, login).first
  end

  def self.find_all_by_query(query)
    where('username ILIKE ? OR race = ? OR server = ? OR league = ?', query, query, query, query)
  end

  def self.find_all_by_username(username)
    where('username ILIKE ?', username)
  end

  def self.find_by_username(username)
    find_all_by_username(username).first
  end

  def tournament_admin
    has_role?(:tournament_admin)
  end

  def tournament_admin=(value)
    if value
      grant(:tournament_admin)
    else
      revoke(:tournament_admin)
    end
  end

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, unless: "self.new_record?"
  validates :password, confirmation: true
  validates_presence_of :password, on: :create
  validates_with TrialEmailValidator

  def bnet_username_is_string
    if bnet_username?
      unless bnet_username =~ /^[^@]+$/
        errors[:bnet_username] << 'can\'t contain the @ symbol, because it is not your email'
      end

      if bnet_username =~ /http:\/\//
        errors[:bnet_username] << 'isn\'t a link to your battle.net profile'
      end
    end
  end

  validate :bnet_username_is_string
  validates :bnet_code,
            format: { with: /\A\d+\z/, message: 'can contain only numbers' },
            if: lambda { |u| u.bnet_username? }

  def bnet_info
    (bnet_username && bnet_code) ? "#{bnet_username}.#{bnet_code}" : nil
  end

  def bnet_info=(value = "")
    if value
      self.bnet_username, self.bnet_code = value.split(".")
    end
  end

  before_save :encrypt_password
  before_save :downcase_race
  before_create { generate_token(:auth_token) }

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def downcase_race
    self.race = self.race.downcase if self.race
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def avatar_image
    avatar.url(:thumb)
  end

  def trial?
    self.expires_at?
  end

  def followed_by?(user)
    Following.exists?(["followee_id = ? AND follower_id = ?", self.id, user.id])
  end

  def following?(user)
    Following.exists?(["followee_id = ? AND follower_id = ?", user.id, self.id])
  end

  def follow(user)
    if following?(user)
      raise "Already following this user"
    else
      Following.create!(follower: self, followee: user)
      self.update_follower_ids
      user.update_follower_ids
    end
  end

  def unfollow(user)
    if following?(user)
      Following.where(follower_id: self.id, followee_id: user.id).destroy_all
      self.update_follower_ids
      user.update_follower_ids
    else
      raise "It's not possible to unfollow without following first"
    end
  end

  def update_follower_ids
    self.follower_ids_cache = followers.pluck(:id).join(" ")
    self.followee_ids_cache = followees.pluck(:id).join(" ")
    save!
  end

  def tournament_admin?
    has_role?(:tournament_admin)
  end

  def playing_in?(tournament)
    Signup.exists?(user_id: self.id, tournament_id: tournament.id)
  end

  def timeline_statuses
    Status.where(user_id: followees.map(&:id) + [self.id]).order("created_at DESC")
  end

end

class NotRegistered < Exception
end
