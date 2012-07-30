require "spec_helper"

describe VoterDecorator do

  let(:voter) { VoterDecorator.new(create(:user)) }

  it "can upvote on statuses" do
    status = create(:status)
    voter.upvote(status)

    status.votes_count.should == 1
  end
end
