class Signup < ActiveRecord::Base
  REGISTERED = 0
  CHECKED = 1
  CANCELED = 2

  scope :registered, where(status: REGISTERED)
  scope :checked,    where(status: CHECKED)

  # TODO - remove signup from here, potentital security risk
  attr_accessible :tournament, :user, :signup

  belongs_to :tournament, counter_cache: true
  belongs_to :user

  has_many :statuses, as: :statusable

  validates :tournament, presence: true
  validates :user, presence: true

  # Create a new signup for a user and a tournament
  def self.for(user, tournament)
    signup = where(user_id: user.id, tournament_id: tournament.id).first
    signup || new(user: user, tournament: tournament)
  end

  def checked?
    self.status == CHECKED
  end

  # Set the signup status and save
  #
  # Returns true if the signup was successful, otherwise false.
  def signup!
    if self.tournament.checkin_open?
      self.status = CHECKED
    else
      self.status = REGISTERED
    end
    self.save!
  end

  def checkin!
    self.status = CHECKED
    self.save!
  end

  def cancel_checkin
    self.status = REGISTERED
    self.save!
  end
end
