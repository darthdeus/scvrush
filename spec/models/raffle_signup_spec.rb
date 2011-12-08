require 'spec_helper'

describe RaffleSignup do
  it "has a valid factory" do
    build(:raffle_signup).should be_valid
  end
end
