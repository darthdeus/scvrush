require 'spec_helper'

describe PostsHelper do
  describe :tournament_shortname do
    it 'strips away the initial tag' do
      tournament_shortname('[NA] foo').should == 'foo'
    end

    it "doesn't strip anything when there's no brackets present" do
      tournament_shortname('foo').should == 'foo'
    end
  end

  describe :strip_markdown do
    it "removes all markdown and returns pure raw text" do
      md = '##Sign Up **- [By Clicking Here](http://scvrush.com/tournaments/41)** ##Date & Time Thursda ...'
      strip_markdown(md).should == "Sign Up - By Clicking Here Date & Time Thursda ..."
    end
  end
end
