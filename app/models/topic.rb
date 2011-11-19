class Topic < ActiveRecord::Base
  # add test for mass assignment check
  attr_accessible :section, :name
  
  belongs_to :section
  belongs_to :user
  has_many :replies

  validates :user, :presence => true
  validates :section, :presence => true
  validates :name, :presence => true
end
