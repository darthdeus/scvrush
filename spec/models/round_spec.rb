require "spec_helper"

describe Round do

  it "has a valid factory" do
    build(:round).should be_valid
  end

  it "requires number for a round" do
    build(:round, number: nil).should_not be_valid
  end

  it "requires a tournament" do
    build(:round, tournament: nil).should_not be_valid
  end

  it "can have a parent" do
    ro4 = create(:round)
    ro2 = create(:round, parent: ro4)

    ro2.parent.should == ro4
    ro4.child.should  == ro2
  end

  describe "next match" do

    it "can tell what the next round is" do
      ro4 = create(:round)
      ro2 = create(:round, child: ro4)
      ro4.next.should == ro2
    end

    it "returns nil if there isn't one" do
      ro4 = create(:round)
      ro4.next.should be_nil
    end

  end

end
