class Signup < ActiveRecord::Base
  REGISTERED = 0
  CHECKED = 1
  CANCELED = 2

  scope :registered, where(:status => REGISTERED)
  scope :checked,    where(:status => CHECKED)

  attr_accessible :tournament, :user

  belongs_to :tournament
  belongs_to :user

  validates :tournament, :presence => true
  validates :user, :presence => true


  def checkin!
    if self.status == REGISTERED
      self.status = CHECKED
      self.save!
    else
      raise "User can't check in after he canceled his registration"
    end
  end
end
