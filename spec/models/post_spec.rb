require 'spec_helper'

describe Post do
  it("should have a valid factory") { build(:post).should be_valid }
  it("requires title")   { build(:post, title: nil) }
  it("requires content") { build(:post, content: nil) }
  its(:status) { should == Post::DRAFT }

  it "should delete all dependent comments" do
    p = create(:post)
    expect {
      create(:comment, post: p)
      p.destroy
    }.not_to change { Comment.count }
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
      post.publish(published: "0").should be_draft
    end

    it "sets status to PUBLISHED for published = 1" do
      post.publish(published: "1", date: '2012-1-1', time: '00:00').should be_published
    end

    it "fails for invalid or missing with published = 1" do
      expect { post.publish(published: "1") }.to raise_error(ArgumentError)
      expect { post.publish(published: "1") }.to raise_error(ArgumentError)
      expect { post.publish(published: "1", time: '00:00') }.to raise_error(ArgumentError)
      expect { post.publish(published: "1", date: '2012-1-1') }.to raise_error(ArgumentError)
    end
  end

end
