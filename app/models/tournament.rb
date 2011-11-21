class Tournament < ActiveRecord::Base
  attr_accessible :starts_at
  
  has_many :signups
  has_many :users, :through => :signups
  
  validates :starts_at, :presence => true
end
