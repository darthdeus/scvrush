class User < ActiveRecord::Base  
  SUBSCRIBER = 0
  WRITER = 1
  ADMIN = 10
  
  
  has_many :comments
  has_many :replies
  has_many :signups
  
  attr_accessible :username, :email, :password, :password_confirmation, :password_reset_token

  acts_as_voter
  has_karma(:comments, :as => :user)

  attr_accessor :password  
  before_save :encrypt_password

  # TODO - use Rails 3 validations
  validates_presence_of :username
  validates :username, :uniqueness => true, :on => :create
  validates_presence_of :email
  validates :email, :uniqueness => true, :on => :create
  validates :password, :confirmation => true
  validates_presence_of :password, :on => :create
  
  # validates_presence_of :bnet_username, :on => :update
  # validates_presence_of :bnet_code, :on => :update

  def is_admin?
    self.role > User::SUBSCRIBER
  end

  def has_bnet_username?
    self.bnet_username && self.bnet_code
  end

  def sign_up(tournament)
    signup = Signup.new
    signup.user = self
    signup.tournament = tournament
    signup.status = Signup::REGISTERED
    signup.save!
  end
  
  def registered_for?(tournament)
    !self.signups.where(:tournament_id => tournament.id, :status => Signup::REGISTERED).empty?
  end

  def checked_in?(tournament)
    !self.signups.where(:tournament_id => tournament.id, :status => Signup::CHECKED).empty?
  end

  def check_in(tournament)
    signup = self.signups.where(:tournament_id => tournament.id).first
    signup.checkin!    
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
  
end
