require 'spec_helper'

describe RaffleSignup do
  it "has a valid factory" do
    build(:raffle_signup).should be_valid
  end
  
  it "requires user" do
    build(:raffle_signup, user: nil).should have_at_least(1).error_on(:user)
  end

  it "requires raffle" do
    build(:raffle_signup, raffle: nil).should have_at_least(1).error_on(:raffle)
  end

end
