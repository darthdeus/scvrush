require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    build(:comment).should be_valid
  end

  it "requires post" do
    build(:comment, :post => nil).should have_at_least(1).error_on(:post)
  end

  it "requires user" do
    build(:comment, :user => nil).should have_at_least(1).error_on(:user)
  end

  it "has a limit on content size" do
    a = [('a'..'z'),('A'..'Z')].map(&:to_a).flatten
    content = (0..500).map { a.sample }.join
    @comment = build(:comment, :content => content)

    @comment.should have_at_least(1).error_on(:content)
  end

  context "votes" do
    it "has no votes when created" do
      create(:comment).votes_for == 0
    end

    it "has one vote for if someone voted" do
      comment = create(:comment)
      user = create(:user)
      user.vote_for(comment)
      comment.votes_for == 1
    end
  end

  describe "#author" do
    it "returns user's username if there is one" do
      comment = build(:comment)
      comment.author.should == comment.user.username
    end

    it "returns nil if there is no author" do
      comment = build(:comment, :user => nil)
      comment.author.should be_nil
    end
  end

  context "replies" do

    it "can have a parent" do
      comment = create(:comment)
      parent = create(:comment)
      comment.parent = parent
      comment.save.should ==true
    end

    it "can have replies" do
      comment = create(:comment)
      3.times { create(:comment, parent_id: comment.id) }
      comment.replies.size.should == 3
    end
  end

  specify :for_post do
    post = create(:post)
    5.times { create(:comment, post_id: post.id) }
    Comment.for_post(post.id).size.should == 5
  end

end
