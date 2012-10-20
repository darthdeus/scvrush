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
      User.delete_all
      t = create(:tournament)
      expect {
        2.times { create(:signup, tournament: t) }
        t.destroy
      }.not_to change{ Signup.count }
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

  describe :unregister do
    it "removes the user from active signups" do
      signup = create(:signup)
      user = signup.user
      tournament = signup.tournament
      tournament.unregister(user)

      player = TournamentPlayerDecorator.new(user, tournament)
      player.should_not be_registered
    end
  end

  it 'has a winner' do
    tournament = create(:tournament)
    user = create(:user)
    tournament.winner = user
    tournament.save!

    user.won_tournaments.should == [tournament]
  end

  it "returns signup for a given user" do
    t = create(:tournament)
    u = create(:user)
    s = create(:signup, user: u, tournament: t)
    t.signup_for(u).should == s
  end

  it "returns registered players" do
    t = create(:tournament)
    u = create(:user)
    t.users << u
    t.registered_players.first.user.should == u
  end

  it "returns checked players" do
    t = create(:tournament)
    u = create(:user)
    t.users << u

    u.check_in(t)
    t.registered_players.first.user.should == u
    t.checked_players.first.should         == u
  end

  it { should respond_to(:logo) }

end
