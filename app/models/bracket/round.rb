class Round < ActiveRecord::Base
  belongs_to :tournament
  attr_accessible :number, :tournament
  validates_presence_of :number, :tournament

  has_many :matches

  # belongs_to :parent
  # has_many :children, class_name: "Round", foreign_key: "parent_id"
end
