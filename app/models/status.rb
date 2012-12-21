class Status < ActiveRecord::Base
  belongs_to :timeline, class_name: "User"
  belongs_to :user

  validates_presence_of :text, :timeline, :user
  attr_accessible :text, :timeline_id, :user_id
end
