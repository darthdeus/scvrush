require 'spec_helper'

describe Achievement do
  it "has a valid factory" do
    build(:achievement).should be_valid
  end

  it "requires a name" do
    build(:achievement, :name => nil).should_not be_valid
  end

  it "sets a slug before it is created" do
    achievement = create(:achievement, :name => "Test")
    achievement.slug.should == "test"
  end

  it "has a dependent destroy" do
    [Achievement, UserAchievement].each(&:destroy_all)

    achievement = create(:achievement)
    user = create(:user)
    user.achievements << achievement

    achievement.destroy
    user.reload
    user.achievements.size.should == 0
    UserAchievement.count.should == 0
  end
end
