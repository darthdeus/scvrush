require 'spec_helper'

describe UserAchievement do
  it "has a valid factory" do
    build(:user_achievement).should be_valid
  end

  it "requires a user" do
    build(:user_achievement, :user => nil).should_not be_valid
  end

  it "requires a achievement" do
    build(:user_achievement, :achievement => nil).should_not be_valid
  end
end
