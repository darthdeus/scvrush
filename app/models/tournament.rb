class Tournament < ActiveRecord::Base
  attr_accessible :starts_at, :name
  
  has_many :signups
  has_many :users, :through => :signups

  validates :name, :presence => true
  validates :starts_at, :presence => true
end
