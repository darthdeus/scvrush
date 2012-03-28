require 'spec_helper'

describe CommentsController do

  before { @user = login }

  specify :create do
    p = create(:post)
    post :create, comment: { content: 'some sample text',
                             post_id: p.id }
    response.should be_success
  end

  specify :destroy do
    comment = create(:comment, user: @user)

    delete :destroy, id: comment.id
    @user.comments.should == []
  end

end
