class Tournament < ActiveRecord::Base
  attr_accessible :starts_at, :name

  has_many :signups, :dependent => :destroy
  has_many :users, :through => :signups

  validates :name, :presence => true
  validates :starts_at, :presence => true

  def signup_open?
    self.starts_at > 30.minutes.from_now
  end

  def checkin_open?
    self.starts_at < 30.minutes.from_now
  end

  def unregister(user)
    self.signups.where(user_id: user.id).first.destroy
  end

end
