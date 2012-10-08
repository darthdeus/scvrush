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

  it 'has a parameterized name' do
    topic = build(:topic, :name => 'foo')
    topic.to_param.should == "#{topic.id}-#{topic.name}"
  end

  describe :create_with_reply do

    let(:user) { create(:user) }
    let(:section) { create(:section) }

    it "creates a Topic and a Reply for valid parameters" do
      Topic.create_with_reply({
                                name: 'My topic',
                                content: 'Content for the reply',
                                user_id: user.id,
                                section_id: section.id
                              })
      Topic.last.name.should == 'My topic'
      Reply.last.content.should == 'Content for the reply'
    end

    it "does a rollback for invalid parameters" do
      Topic.create_with_reply({
                                name: 'My topic',
                                user_id: user.id,
                                section_id: section.id
                              }).should == false
    end

  end

end
