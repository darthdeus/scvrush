require "spec_helper"

describe Following do

  it "requires follower and followee" do
    build(:following, follower: nil).should_not be_valid
    build(:following, followee: nil).should_not be_valid
  end

  it "allows one user to follow another" do
    u = create(:user)
    u2 = create(:user)

    u.follow(u2)

    u.following?(u2).should be_true
    u2.followed_by?(u).should be_true

    u2.follow(u)

    u2.following?(u).should be_true
    u.followed_by?(u2).should be_true

    u.unfollow(u2)

    u.following?(u2).should be_false
    u2.followed_by?(u).should be_false
  end

end
