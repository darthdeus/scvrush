require 'spec_helper'

describe Post do
  it "should have a valid factory" do
    build(:post).should be_valid
  end

  it "requires title" do
    build(:post, title: nil)
  end

  it "requires content" do
    build(:post, content: nil)
  end

  it "is created as draft" do
    create(:post).status == Post::DRAFT
  end

  it "should delete all dependent comments" do
    p = create(:post)
    create(:comment, post: p)
    p.destroy

    Comment.all.size.should == 0
  end

  it 'has a parameterized name' do
    post = build(:post, title: 'foo')
    post.to_param.should == "#{post.id}-#{post.title}"
  end

  specify :draft? do
    build(:post, status: Post::DRAFT).should be_draft
    build(:post, status: Post::PUBLISHED).should_not be_draft
  end

  specify :published? do
    build(:post, status: Post::DRAFT).should_not be_published
    build(:post, status: Post::PUBLISHED).should be_published
  end

  describe :publish do
    let(:post) { Post.new }

    it "sets status to DRAFT for published = 0" do
      post.publish(published: "0")
      post.should be_draft
    end

    it "sets status to PUBLISHED for published = 1" do
      post.publish(published: "1", date: '2012-1-1', time: '00:00')
      post.should be_published
    end

    it "fails for invalid or missing with published = 1" do
      expect {
        post.publish(published: "1")
      }.to raise_error(ArgumentError)

      expect {
        post.publish(published: "1")
      }.to raise_error(ArgumentError)

      expect {
        post.publish(published: "1", time: '00:00')
      }.to raise_error(ArgumentError)

      expect {
        post.publish(published: "1", date: '2012-1-1')
      }.to raise_error(ArgumentError)
    end
  end

end
