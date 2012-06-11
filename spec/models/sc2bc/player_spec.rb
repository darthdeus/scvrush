require "spec_helper"

describe Player do

  describe "validations" do
    it "has a valid factory" do
      build(:player).should be_valid
    end
  end

end
