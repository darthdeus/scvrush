class RaffleSignup < ActiveRecord::Base
  belongs_to :raffle
  belongs_to :user

  validates_presence_of :raffle
  validates_presence_of :user
end
