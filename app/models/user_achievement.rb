class UserAchievement < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :user

  validates_presence_of :achievement, :user

  # TODO - investigate if we need this
  attr_accessible :user_id, :achievement_id
end
