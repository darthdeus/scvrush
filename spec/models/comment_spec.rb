require 'spec_helper'

describe Comment do
  it "has a valid factory" do
    build(:comment).should be_valid
  end

  it "requires post" do
    build(:comment, post: nil).should have_at_least(1).error_on(:post)
  end

  it "requires user" do
    build(:comment, user: nil).should have_at_least(1).error_on(:user)
  end

  it "has a limit on content size" do
    content = "a" * 900
    comment = build(:comment, :content => content)
    comment.should have_at_least(1).error_on(:content)
  end

  context "replies" do

    it "can have a parent" do
      comment = create(:comment)
      parent = create(:comment)
      comment.parent = parent
      comment.save.should == true
    end

    it "can have replies" do
      comment = create(:comment)
      create(:comment, parent_id: comment.id)
      comment.replies.should have(1).item
    end
  end

  specify :for_post do
    post = create(:post)
    create(:comment, post_id: post.id)
    Comment.for_post(post.id).should have(1).item
  end


  describe :threaded_comments do

    it "doesn't display comments who's parent was deleted" do
      post = create(:post)

      first  = create(:comment, post_id: post.id)
      second = create(:comment, post_id: post.id)
      third  = create(:comment, post_id: post.id)

      reply  = create(:comment, post_id: post.id, parent_id: first.id)

      post.comments.should == [first, second, third, reply]
      Comment.threaded_for_post(post.id).should == [first, reply, second, third]
      first.destroy

      Comment.threaded_for_post(post.id).should == [second, third]
    end

  end

end
