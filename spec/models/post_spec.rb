require 'spec_helper'

describe Post do
  it "should have a valid factory" do
    build(:post).should be_valid
  end
  
  it "requires title" do
    build(:post, :title => nil)
  end
  
  it "requires content" do
    build(:post, :content => nil)    
  end
  
  it "is created as draft" do
    create(:post).status == Post::DRAFT
  end

  it "should delete all dependent comments" do
    p = create(:post)
    create(:comment, :post => p)
    p.destroy
    
    Comment.all.size.should == 0
  end
end
