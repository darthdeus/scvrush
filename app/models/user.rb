class User < ActiveRecord::Base
  rolify
  include BattleNet
  include Player

  scope :with_bnet_info, where("bnet_username IS NOT NULL AND bnet_code IS NOT NULL")

  has_and_belongs_to_many :roles, join_table: :users_roles

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
                  :image, :bnet_info, :expires_at


  attr_accessor :password

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

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
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

  def bnet_info
    (bnet_username && bnet_code) ? "#{bnet_username}.#{bnet_code}" : nil
  end

  def bnet_info=(value = "")
    if value
      self.bnet_username, self.bnet_code = value.split(".")
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

  def avatar_image
    avatar.url(:thumb)
  end

  def trial?
    self.expires_at?
  end

end

class NotRegistered < Exception
end
