require 'spec_helper'

describe BlogPost do
  it "has a valid factory" do
    build(:blog_post).should be_valid
  end

  it "requires a title" do
    post = build(:blog_post, title: nil)
    post.should have_at_least(1).error_on(:title)
  end

  it "requires a url" do
    post = build(:blog_post, url: nil)
    post.should have_at_least(1).error_on(:url)
  end

  it "requires a order" do
    post = build(:blog_post, order: nil)
    post.should have_at_least(1).error_on(:order)
  end
end
