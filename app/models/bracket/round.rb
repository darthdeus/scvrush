class Round < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :number
  validates_presence_of :number, :tournament
end
