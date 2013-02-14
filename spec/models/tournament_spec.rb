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

  it "can have a winner" do
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
    t.registered_players.should == [u]
  end

  it "returns checked players" do
    t = create(:tournament)
    u = create(:user)
    t.users << u

    u.check_in(t)
    t.registered_players.should == [u]
    t.checked_players.should    == [u]
  end

  it { should respond_to(:logo) }

  context "#as_json" do

    let(:tournament) { create(:tournament) }

    context "without user" do
      subject(:json) { tournament.as_json }

      it "lists the number of participans" do
        pending "Test the serializer instead"
        json["participant_count"].should == 0
      end

      it "has the tournament image" do
        pending "Test the serializer instead"
        json.should have_key("image_name")
      end
    end

    context "with user" do
      let(:user)       { create(:user) }
      subject(:player) { TournamentPlayerDecorator.new(user, tournament) }

      it "renders itself as a json" do
        pending "Test the serializer instead"
        tournament.as_json(user: user)["is_registered"].should be_false
        player.register.save!
        tournament.as_json(user: user)["is_registered"].should be_true
      end

    end

  end

end
