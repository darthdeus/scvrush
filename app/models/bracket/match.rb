class Match < ActiveRecord::Base
  has_many :games
  attr_accessible :bo

  validates_presence_of :bo
end
