require 'spec_helper'

describe Point do
  it "has a valid factory" do
    build(:point).should be_valid
  end

  it 'requires a user' do
    build(:point, user: false).should_not be_valid
  end

end
