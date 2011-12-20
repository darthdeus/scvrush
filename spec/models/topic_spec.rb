require 'spec_helper'

describe Topic do
  it 'has a valid factory' do
    build(:topic).should be_valid
  end

  describe '#last_reply' do
    let(:topic) { create(:topic) }

    it 'returns a reply when there is one' do
      reply = create(:reply, :topic_id => topic.id)
      topic.reload
      topic.last_reply.should == reply
    end

    it 'returns no date when there are no replies in the topic' do
      topic.last_reply.should be_nil
    end

    it 'returns the last reply when there are multiple ones' do
      topic.replies.destroy_all
      3.times { create(:reply, :topic_id => topic.id) }
      topic.reload
      topic.last_reply.should == Reply.last
    end
  end

  describe '#last_reply_at' do
    let(:topic) { create(:topic) }

    it 'contains last reply created_at time' do
      topic.replies.destroy_all
      create(:reply, :topic_id => topic.id)
      topic.reload
      topic.last_reply_at.should == topic.last_reply.created_at
    end
  end
end
