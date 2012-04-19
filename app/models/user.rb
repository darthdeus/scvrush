class User < ActiveRecord::Base
  include Rolify::Roles
  # TODO - what is this? how does it differ from Rolify::Roles?
  # extend Rolify::Dynamic

  has_and_belongs_to_many :roles, join_table: :users_roles

  has_many :user_achievements
  has_many :achievements, through: :user_achievements

  has_many :comments
  has_many :replies
  has_many :signups, dependent: :destroy
  has_many :tournaments, through: :signups
  has_many :won_tournaments, class_name: 'Tournament', foreign_key: 'winner_id'

  has_many :posts
  has_many :won_raffles, class_name: 'Raffle', foreign_key: 'winner_id'

  has_many :raffle_signups
  has_many :raffles, through: :raffle_signups

  attr_accessible :username, :email, :password, :password_confirmation,
                  :password_reset_token, :avatar, :race, :league, :server,
                  :favorite_player, :skype, :display_skype, :msn,
                  :display_msn, :display_email, :about, :avatar,
                  :bnet_code, :bnet_username, :twitter, :time_zone, :practice

  acts_as_voter
  has_karma(:comments, as: :user)



  attr_accessor :password
  before_save :encrypt_password

  mount_uploader :avatar, AvatarUploader

  scope :practice, where(practice: true)

  # TODO - use Rails 3 validations
  validates_presence_of :username
  validates :username, uniqueness: true, on: :create
  validates_presence_of :email
  validates :email, uniqueness: true, on: :create
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
  # validates :bnet_username,
  #           :format => { :with => /^[^@]+$/,
  #                        :message => 'can\'t contain the @ symbol, because it is not your email' },
  #           :if => lambda { |u| u.bnet_username? }

  validates :bnet_code,
            format: { with: /^\d+$/,
                         message: 'can contain only numbers' },
            if: lambda { |u| u.bnet_username? }

  # validates_presence_of :bnet_username, :on => :update
  # validates_presence_of :bnet_code, :on => :update

  def bnet_info
    "#{self.bnet_username}.#{self.bnet_code}"
  end

  def is_admin?
    self.has_role? :admin
  end

  def is_writer?
    self.has_role? :writer
  end

  def has_bnet_username?
    self.bnet_username.present? && self.bnet_code.present?
  end

  def sign_up(tournament)
    # TODO - Does this actually create the correct signup?
    signup = self.signups.build(tournament: tournament)
    signup.status = Signup::REGISTERED
    signup.save!
    signup
  end

  def registered_for?(tournament)
    !self.signups.registered.where(tournament_id: tournament.id).empty?
  end

  def checked_in?(tournament)
    !self.signups.checked.where(tournament_id: tournament.id).empty?
  end

  def check_in(tournament)
    signup = self.signups.where(tournament_id: tournament.id).first
    if signup
      signup.checkin!
    else
      raise NotRegistered.new("Trying to check in a user who isn't registered!")
    end
  end

  def participating_in?(raffle)
    self.raffle_signups.where(raffle_id: raffle.id).first
  end

  def to_param
    "#{id}-#{username.parameterize}"
  end

  def generate_api_key!
    self.api_key = BCrypt::Engine.generate_salt
    self.save!
  end

  before_create { generate_token(:auth_token) }

  def self.authenticate(username, password)
    user = self.where('username = ? OR email = ?', username, username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def won_tournament!
    achievement = Achievement.find_or_create_by_name("Tournament winner")
    self.achievements << achievement unless self.achievements.include?(achievement)
    self.save!
  end

end

# TODO - move this some place else!
class NotRegistered < Exception
end
