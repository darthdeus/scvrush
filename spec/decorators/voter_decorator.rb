require "spec_helper"

describe VoterDecorator do

  let(:voter) { VoterDecorator.new(create(:user)) }

  it "can upvote on statuses" do
    status = create(:status)
    voter.upvote(status)

    # this also tests that the decorator will recalculate vote count
    status.votes_count.should == 1
  end
end
