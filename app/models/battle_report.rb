class BattleReport < ActiveRecord::Base
  attr_accessible :title, :content, :tournament_id
  belongs_to :tournament
  validates_presence_of :title, :content, :tournament_id
end
