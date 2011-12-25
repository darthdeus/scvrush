require 'spec_helper'

describe PostsHelper do
  describe '#tournament_shortname' do
    it 'strips away the initial tag' do
      tournament_shortname('[NA] foo').should == 'foo'
    end

    it "doesn't strip anything when there's no brackets present" do
      tournament_shortname('foo').should == 'foo'
    end
  end
end
