require 'spec_helper'

describe TournamentsHelper do
  describe "signups_open?" do
    it "returns true if tournament starts in more than 15 minutes" do
      tournament = mock('tournament')
      tournament.should_receive(:starts_at).and_return(20.minutes.from_now)
      
      signups_open?(tournament).should be_true
    end
    
    it "returns false if tournament starts in less than 15 minutes" do
      tournament = mock('tournament')
      tournament.should_receive(:starts_at).and_return(10.minutes.from_now)
      
      signups_open?(tournament).should be_false      
    end
  end
end
