require 'spec_helper'

describe CommentsController do

  before { @user = login }

  specify :index do
    p = create(:post)
    5.times { create(:comment, post_id: p.id )}

    p.comments.size.should == 5

    get :index, post_id: p.id
    response.should be_success
  end

  specify :create do
    p = create(:post)
    post :create, comment: { content: 'some sample text',
                             post_id: p.id }
    response.should be_success
  end

  it "assigns parent_id if given" do
    p = create(:post)
    c = create(:comment, post_id: p.id)
    post :create, comment: { content: 'some sample text',
                              post_id: p.id,
                              parent_id: c.id }

    c.replies.should == [Comment.last]
    p.comments.size.should == 2
  end

  specify :destroy do
    comment = create(:comment, user: @user)

    delete :destroy, id: comment.id
    @user.comments.should == []
  end

end
