require 'spec_helper'

describe Tournament do
  describe "validations" do
    it "has a valid factory" do
      build(:tournament).should be_valid
    end

    it "requires name" do
      build(:tournament, :name => nil).should_not be_valid
    end

    it "requires start date" do
      build(:tournament, :starts_at => nil).should_not be_valid
    end

    it "deletes all dependent signups when destroyed" do
      t = create(:tournament)
      create(:signup, :tournament => t)
      create(:signup, :tournament => t)

      t.destroy
      Signup.all.size.should == 0
    end

    it 'has a post' do
      tournament = create(:tournament)
      tournament.post.should_not be_nil
    end

    it 'has a parameterized name' do
      tournament = build(:tournament, :name => 'foo')
      tournament.to_param.should == "#{tournament.id}-#{tournament.name}"
    end
  end

  describe :signup_open? do
    it "returns false if tournament starts in more than 30 minutes" do
      [31, 60, 90, 240].each do |n|
        tournament = build(:tournament, starts_at: n.minutes.from_now)
        tournament.checkin_open?.should be_false
        tournament.signup_open?.should be_true
      end
    end

    it "returns true if tournament starts in less than 30 minutes" do
      [15, 10, 5, 1].each do |n|
        tournament = build(:tournament, starts_at: n.minutes.from_now)
        tournament.checkin_open?.should be_true
        tournament.signup_open?.should be_false
      end
    end
  end

  describe :unregister do
    it "removes the user from active signups" do
      @signup = create(:signup)
      @user = @signup.user
      @tournament = @signup.tournament
      @tournament.unregister(@user)

      @user.should_not be_registered_for(@tournament)
    end
  end

  it 'has a winner' do
    tournament = create(:tournament)
    user = create(:user)
    tournament.winner = user
    tournament.save!

    user.won_tournaments.should == [tournament]
  end
end
