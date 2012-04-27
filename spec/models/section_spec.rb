require 'spec_helper'

describe Section do

  it 'has a valid factory' do
    build(:section).should be_valid
  end

  it "removes all dependent topics" do
    Topic.destroy_all
    section = create(:section)
    create(:topic, section_id: section.id)
    section.destroy
    Topic.count.should == 0
  end

end
