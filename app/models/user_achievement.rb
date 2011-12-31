class UserAchievement < ActiveRecord::Base
  belongs_to :achievement
  belongs_to :user

  validates_presence_of :achievement, :user
end
