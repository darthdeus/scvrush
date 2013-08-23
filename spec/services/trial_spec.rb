require "spec_helper"

describe Trial do
  it "creates a new random user" do
    session = {}
    Trial.new.create(session, "127.0.0.1")

    session.should have_key(:user_id)
    User.count.should == 1
  end
end
