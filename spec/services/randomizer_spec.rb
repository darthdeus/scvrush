require "spec_helper"

describe Randomizer do

  it "returns random usernames" do
    Randomizer.username.should_not eq Randomizer.username
  end

  it "returns email which belongs to a username" do
    username, email = Randomizer.credentials
    email[username].should eq username
  end

end
