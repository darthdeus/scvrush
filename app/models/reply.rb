class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  
  validates :topic, :presence => true
  validates :user, :presence => true
  validates :content, :presence => true
end
