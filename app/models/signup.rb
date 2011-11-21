class Signup < ActiveRecord::Base
  attr_accessible :tournament

  belongs_to :tournament
  belongs_to :user
  
  validates :tournament, :presence => true
  validates :user, :presence => true
  
end
