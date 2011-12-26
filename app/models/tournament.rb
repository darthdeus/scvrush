class Tournament < ActiveRecord::Base
  has_many :signups, :dependent => :destroy
  has_many :users, :through => :signups

  belongs_to :post

  validates :name, :presence => true
  validates :starts_at, :presence => true

  scope :recent, order('starts_at DESC').limit(5)
  scope :upcoming, order('starts_at DESC').limit(2)

  def signup_open?
    self.starts_at > 30.minutes.from_now
  end

  def checkin_open?
    self.starts_at < 30.minutes.from_now
  end

  def unregister(user)
    self.signups.where(user_id: user.id).first.destroy
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
