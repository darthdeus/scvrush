require 'spec_helper'

describe Signup do

  it "requires a tournament" do
    signup = build(:signup, tournament: nil)
    signup.should_not be_valid
    signup.should have_at_least(1).error_on(:tournament)

    expect {
      signup.save!
    }.to raise_exception
  end

  it "has default value of REGISTERED" do
    create(:signup, :status => nil).status == Signup::REGISTERED
  end

  describe "#checkin" do
    it "sets status to checked" do
      signup = create(:signup)
      signup.checkin!
      signup.status.should == Signup::CHECKED
    end
  end

end
