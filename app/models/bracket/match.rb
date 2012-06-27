class Match < ActiveRecord::Base
  has_many :games
  attr_accessible :bo
end
