class Signup < ActiveRecord::Base
  REGISTERED = 0
  CHECKED = 1
  CANCELED = 2

  scope :registered, where(status: REGISTERED)
  scope :checked,    where(status: CHECKED)

  # TODO - remove signup from here, potentital security risk
  attr_accessible :tournament, :user, :signup, :status, :user_id, :tournament_id

  belongs_to :tournament, counter_cache: true
  belongs_to :user

  has_many :statuses, as: :statusable

  validates_presence_of :status, :tournament_id, :user

  before_save do
    self.status = Signup::REGISTERED unless self.status
  end

  # Create a new signup for a user and a tournament
  def self.for(user, tournament)
    signup = where(user_id: user.id, tournament_id: tournament.id).first
    signup || new(user: user, tournament: tournament)
  end

  def checked?
    self.status == CHECKED
  end

  def register
    self.status = REGISTERED
    self.save
  end

  def checkin
    self.status = CHECKED
    self.save
  end

  def cancel
    self.status = CANCELED
    self.save
  end

end
