class Reply < ActiveRecord::Base
  # add test for mass assignment check
  attr_accessible :topic, :content
  
  belongs_to :topic
  belongs_to :user
  
  validates :topic, :presence => true
  validates :user, :presence => true
  validates :content, :presence => true
end
