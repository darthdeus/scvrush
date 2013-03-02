require 'spec_helper'

describe Post do
  it("should have a valid factory") { build(:post).should be_valid }
  it("requires title")   { build(:post, title: nil) }
  it("requires content") { build(:post, content: nil) }
  its(:status) { should == Post::DRAFT }

  specify :draft? do
    build(:post, status: Post::DRAFT).should be_draft
    build(:post, status: Post::PUBLISHED).should_not be_draft
  end

  specify :published? do
    build(:post, status: Post::DRAFT).should_not be_published
    build(:post, status: Post::PUBLISHED).should be_published
  end

end
