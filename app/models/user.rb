class User < ActiveRecord::Base
  rolify
  include BattleNet
  include Player

  scope :with_bnet_info, where("bnet_username IS NOT NULL AND bnet_code IS NOT NULL")

  has_and_belongs_to_many :roles, join_table: :users_roles

  has_many :user_achievements
  has_many :achievements, through: :user_achievements

  has_many :comments
  has_many :replies
  has_many :signups, dependent: :destroy
  has_many :tournaments, through: :signups
  has_many :won_tournaments, class_name: "Tournament", foreign_key: "winner_id"

  has_many :owned_tournaments, class_name: "Tournament", foreign_key: "user_id"

  has_many :statuses

  has_many :posts
  has_many :won_raffles, class_name: "Raffle", foreign_key: "winner_id"
  has_many :votes

  has_many :raffle_signups
  has_many :raffles, through: :raffle_signups

  has_many :following_relationships, class_name: "Relationship", foreign_key: "requestor_id"
  has_many :notifications, dependent: :destroy, order: "created_at DESC"
  # ActiveRecord reputation system
  has_many :evaluations, class_name: "RSEvaluation", as: :source

  attr_accessible :username, :email, :password, :password_confirmation,
                  :password_reset_token, :avatar, :race, :league, :server,
                  :favorite_player, :skype, :display_skype, :msn,
                  :display_msn, :display_email, :about, :avatar,
                  :bnet_code, :bnet_username, :twitter, :time_zone, :practice,
                  :image, :bnet_info, :expires_at


  attr_accessor :password
  acts_as_followable

  mount_uploader :avatar, AvatarUploader

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # settings analysis: {
  #   filter: {
  #     ngram_filter: {
  #       type: "nGram",
  #       min_gram: 3,
  #       max_gram: 8
  #     }
  #   },
  #   analyzer: {
  #     ngram_analyzer: {
  #       tokenizer: "lowercase",
  #       filter: ["ngram_filter"],
  #       type: "custom"
  #     }
  #   }
  # } do
  #   mapping do
  #     indexes :username, type: 'string', analyzer: 'ngram_analyzer', boost: 100
  #   end
  # end

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

  # Return a user either by his username or by email.
  # Used mostly for authentication purposes.
  def self.with_login(login)
    where('username ILIKE ? OR email ILIKE ?', login, login).first
  end

  def self.find_all_by_username(username)
    where('username ILIKE ?', username)
  end

  def self.find_by_username(username)
    find_all_by_username(username).first
  end

  def self.filtered(params)
    res = self
    res = res.where(race:   params[:race]) if params[:race] && params[:race] != 'Any'
    res = res.where(server: params[:server]) if params[:server]
    res = res.where(league: params[:league]) if params[:league]
    return res
  end

  # TODO - why is here on: :create?
  validates :username, presence: true, uniqueness: true, on: :create
  # TODO - why is here on: :create?
  validates :email, presence: true, uniqueness: true, on: :create
  validates :password, confirmation: true
  validates_presence_of :password, on: :create

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
            format: { with: /^\d+$/, message: 'can contain only numbers' },
            if: lambda { |u| u.bnet_username? }

  def to_s
    if bnet_info?
      "#{username} - #{bnet_info}"
    else
      username
    end
  end

  def bnet_info
    (bnet_username && bnet_code) ? "#{bnet_username}.#{bnet_code}" : nil
  end

  # TODO - check for this on the client as well
  def bnet_info=(value = "")
    if value
      bnet_username, bnet_code = value.split(".")
    end
  end

  before_save :encrypt_password
  before_create { generate_token(:auth_token) }

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def following_ids
    # TODO - make this more performant
    following.map(&:id)
  end

  def won_tournament!
    achievement = Achievement.find_or_create_by_name("Tournament winner")
    self.achievements << achievement unless self.achievements.include?(achievement)
    self.save!
  end

  # Users are friends if they are following eachother
  def friends
    self.followers & self.followings.map(&:requestor)
  end

  def friend?(user)
    self.following?(user) && user.following?(self)
  end

  # Return all ids from the users the current user is following,
  # include his own. Used to query statuses for user's timeline.
  def timeline_ids
    self.following.map(&:id) << self.id
  end

  def avatar_image
    avatar.url(:thumb)
  end

  def trial?
    self.expires_at?
  end

end

class NotRegistered < Exception
end
