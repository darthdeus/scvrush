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
  end
  
  describe :signup_open? do
    it "returns false if tournament starts in more than 15 minutes" do
      [16, 20, 30, 60, 90, 240].each do |n|
        tournament = build(:tournament, starts_at: n.minutes.from_now)
        tournament.checkin_open?.should be_false
        tournament.signup_open?.should be_true
      end      
    end
    
    it "returns true if tournament starts in less than 15 minutes" do
      [15, 10, 5, 1].each do |n|
        tournament = build(:tournament, starts_at: n.minutes.from_now)
        tournament.checkin_open?.should be_true
        tournament.signup_open?.should be_false
      end
    end
  end
end
