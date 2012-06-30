require "spec_helper"

describe Bracket::Bracket do

  let(:bracket) { Bracket::Bracket.new([]) }

  describe "seed size" do
    it "returns the next highest possible seed size for a given number" do
      bracket.find_seed(100).should == 128
      bracket.find_seed(60).should == 64
      bracket.find_seed(20).should == 32
      bracket.find_seed(17).should == 32
      bracket.find_seed(16).should == 16
    end

    it "won't allow to seed larger than maximum bracket" do
      expect { bracket.find_seed(200) }.to raise_error(ArgumentError)
    end

  end


end
