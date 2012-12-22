require "spec_helper"

describe Status do

  it "has a valid factory" do
    build(:status).should be_valid
  end

  # TODO - add shoulda matchers
  # it { should validate_presence_of(:text) }
  it { build(:status, text:        nil).should_not be_valid }
  it { build(:status, user_id:     nil).should_not be_valid }

 # its(:likes_count) { should == 0 }

  # describe "#like" do
  #   before { @status = build(:status); @status.like("johndoe") }

  #   it "adds the vote and saves the voter" do
  #     @status.likes_count.should == 1
  #     @status.voters.should == ["johndoe"]
  #   end

  #   it "allows each user to like only once" do
  #     @status.like("johndoe").should == false
  #     @status.likes_count.should == 1
  #     @status.voters.should == ["johndoe"]
  #   end

  # end

  # describe "#unlike" do
  #   before { @status = build(:status); @status.like("johndoe") }

  #   it "removes the previous vote and the voter" do
  #     @status.unlike("johndoe")
  #     @status.likes_count.should == 0
  #     @status.voters.should be_empty
  #   end

  #   it "returns false if there is no previous vote" do
  #     @status.unlike("katie").should == false
  #   end

  # end

end
