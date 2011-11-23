require 'spec_helper'

describe Point do
  it "has a valid factory" do
    build(:point).should be_valid
  end
end
