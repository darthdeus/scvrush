class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  
  validates :content, :presence => true
end
