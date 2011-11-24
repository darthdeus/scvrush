class Signup < ActiveRecord::Base
  REGISTERED = 0
  CHECKED = 1
  CANCELED = 2

  scope :registered, where(:status => REGISTERED)
  scope :checked, where(:status => CHECKED)
  
  attr_accessible :tournament, :user

  belongs_to :tournament
  belongs_to :user
  
  validates :tournament, :presence => true
  validates :user, :presence => true
  
end
