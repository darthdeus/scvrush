require 'spec_helper'

describe Raffle do
  it "has a valid factory" do
    build(:raffle).should be_valid
  end
end
