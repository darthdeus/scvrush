class Following < ActiveRecord::Base
  attr_accessible :followee_id, :follower, :follower_id, :followee

  belongs_to :follower, class_name: "User", foreign_key: "follower_id"
  belongs_to :followee, class_name: "User", foreign_key: "followee_id"

  validates_presence_of :follower, :followee
end
