class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :timeline, class_name: "User"

  validates_presence_of :text, :user, :timeline

  attr_accessible :text, :user, :timeline
end
