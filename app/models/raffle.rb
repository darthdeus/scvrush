class Raffle < ActiveRecord::Base
  CREATED = 0
  OPEN = 1
  FINISHED = 2
  
  belongs_to :winner, :class_name => "User", :foreign_key => "winner_id"
  has_many :raffle_signups
  has_many :users, :through => :raffle_signups
  
  validates_presence_of :status
  validates_presence_of :title
end
