require 'spec_helper'

describe Section do
  it 'has a valid factory' do
    build(:section).should be_valid
  end
end
