require 'spec_helper'

describe Raffle do
  it "has a valid factory" do
    build(:raffle).should be_valid
  end
  
  it "requires title" do
    build(:raffle, title: nil).should_not be_valid
  end
  
  it "requires status" do
    build(:raffle, status: nil).should_not be_valid
  end

  it "doesn't have a winner by default" do
    build(:raffle).winner.should be_nil
  end
  
  it "has default status of DRAFT" do
    @raffle = create(:raffle)
    @raffle.status.should == Raffle::DRAFT
  end
  
  describe "#start!" do
    it "sets status to OPEN" do
      @raffle = create(:raffle)
      @raffle.start!
      @raffle.status.should == Raffle::OPEN
    end
  end
  
  describe "#finish!" do
    it "sets status to FINISHED" do
      @raffle = create(:raffle)
      @raffle.finish!
      @raffle.status.should == Raffle::FINISHED
    end
  end
  
  describe "#calculate_winner" do        
    it "returns a random signed user" do
      User.destroy_all
      Raffle.destroy_all
      @raffle = create(:raffle)
      
      3.times { create(:raffle_signup, raffle: @raffle) }
      @raffle.users.size.should == 3            
            
      User.all.should include(@raffle.calculate_winner)
    end
    
    it "closes the raffle" do
      @raffle = create(:raffle)
      
      3.times { create(:raffle_signup, raffle: @raffle) }
      @raffle.calculate_winner
      @raffle.status.should == Raffle::FINISHED
    end
  end
  
  it "destroys all it's raffle_signups upon deletion" do
    Raffle.destroy_all
    RaffleSignup.destroy_all
    @raffle = create(:raffle)
    3.times { create(:raffle_signup, raffle: @raffle) }
    @raffle.raffle_signups.size.should == 3
    
    @raffle.destroy
    RaffleSignup.count.should == 0
  end
  
  describe "#signup" do
    it "creates raffle_signup for a given user" do
      @raffle = create(:raffle)
      @user = create(:user)
      @raffle.register(@user)
      
      @user.should be_participating_in(@raffle)
    end
  end
  
  describe "#is_open?" do
    it "returns true if status is OPEN" do
      build(:raffle, status: Raffle::OPEN).is_open?.should be_true
    end

    it "returns false if status is DRAFT" do
      build(:raffle, status: Raffle::DRAFT).is_open?.should be_false
    end
    
    it "returns false if status is FINISHED" do
      build(:raffle, status: Raffle::FINISHED).is_open?.should be_false
    end    

  end
end
