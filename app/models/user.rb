class User < ActiveRecord::Base
  SUBSCRIBER = 0
  WRITER = 1
  ADMIN = 10

  has_many :user_achievements
  has_many :achievements, :through => :user_achievements

  has_many :comments
  has_many :replies
  has_many :signups
  has_many :tournaments, :through => :signups
  has_many :won_tournaments, :class_name => 'Tournament', :foreign_key => 'winner_id'

  has_many :posts
  has_many :won_raffles, :class_name => 'Raffle', :foreign_key => 'winner_id'

  has_many :raffle_signups
  has_many :raffles, :through => :raffle_signups

  attr_accessible :username, :email, :password, :password_confirmation,
                  :password_reset_token, :avatar, :race, :league, :server,
                  :favorite_player, :skype, :display_skype, :msn,
                  :display_msn, :display_email, :about, :avatar,
                  :bnet_code, :bnet_username, :twitter

  acts_as_voter
  has_karma(:comments, :as => :user)

  attr_accessor :password
  before_save :encrypt_password

  mount_uploader :avatar, AvatarUploader

  # TODO - use Rails 3 validations
  validates_presence_of :username
  validates :username, :uniqueness => true, :on => :create
  validates_presence_of :email
  validates :email, :uniqueness => true, :on => :create
  validates :password, :confirmation => true
  validates_presence_of :password, :on => :create
  validates :bnet_username,
            :format => { :with => /^[\w\d]+$/,
                         :message => 'can contain only letters and numbers' },
            :if => lambda { |u| u.bnet_username? }

  validates :bnet_code,
            :format => { :with => /^\d+$/,
                         :message => 'can contain only numbers' },
            :if => lambda { |u| u.bnet_username? }

  # validates_presence_of :bnet_username, :on => :update
  # validates_presence_of :bnet_code, :on => :update

  def bnet_info
    "#{self.bnet_username}.#{self.bnet_code}"
  end

  def is_admin?
    self.role == User::ADMIN
  end

  def is_writer?
    self.role > User::SUBSCRIBER
  end

  def has_bnet_username?
    self.bnet_username && self.bnet_code
  end

  def sign_up(tournament)
    # TODO - Does this actually create the correct signup?
    self.signups.create!(:tournament => tournament, :status => Signup::REGISTERED)
  end

  def registered_for?(tournament)
    !self.signups.registered.where(:tournament_id => tournament.id).empty?
  end

  def checked_in?(tournament)
    !self.signups.checked.where(:tournament_id => tournament.id).empty?
  end

  def check_in(tournament)
    signup = self.signups.where(:tournament_id => tournament.id).first
    if signup
      signup.checkin!
    else
      raise NotRegistered.new("Trying to check in a user who isn't registered!")
    end
  end

  def participating_in?(raffle)
    self.raffle_signups.where(:raffle_id => raffle.id).first
  end

  def to_param
    "#{id}-#{username.parameterize}"
  end

  before_create { generate_token(:auth_token) }

  def self.authenticate(username, password)
    user = find_by_username(username)
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

