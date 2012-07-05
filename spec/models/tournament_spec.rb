require 'spec_helper'

describe Tournament do
  describe "validations" do
    it "has a valid factory" do
      build(:tournament).should be_valid
    end

    it "requires name" do
      build(:tournament, name: nil).should_not be_valid
    end

    it "requires start date" do
      build(:tournament, starts_at: nil).should_not be_valid
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

  describe :upcoming do
    it "it returns two upcoming tournaments, not last two" do
      Tournament.destroy_all

      t1 = create(:tournament, starts_at: 1.hour.from_now)
      t2 = create(:tournament, starts_at: 2.hour.from_now)
      t3 = create(:tournament, starts_at: 3.hour.from_now)
      t4 = create(:tournament, starts_at: 4.hour.from_now)

      Tournament.upcoming.should == [t1, t2]
    end
  end

  describe :unregister do
    it "removes the user from active signups" do
      signup = create(:signup)
      user = signup.user
      tournament = signup.tournament
      tournament.unregister(user)

      user.should_not be_registered_for(tournament)
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
