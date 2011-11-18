class Topic < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :replies
  
  validates :name, :presence => true
end
