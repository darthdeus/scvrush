class Signup < ActiveRecord::Base
  REGISTERED = 0
  CHECKED = 1
  CANCELED = 2

  scope :registered, where(status: REGISTERED)
  scope :checked,    where(status: CHECKED)

  # TODO - remove signup from here, potentital security risk
  attr_accessible :tournament, :user, :signup

  belongs_to :tournament
  belongs_to :user

  validates :tournament, presence: true
  validates :user, presence: true

  # Create a new signup for a user and a tournament
  def self.for(user, tournament)
    instance = new(user: user, tournament: tournament)
  end

  # Set the signup status and save
  #
  # Returns true if the signup was successful, otherwise false.
  def signup!
    self.status = REGISTERED
    self.save
  end

  def checkin!
    if self.status == REGISTERED
      self.status = CHECKED
      self.save!
    else
      raise "User can't check in after he canceled his registration"
    end
  end
end
