require 'spec_helper'

describe Tournament do
  describe "validations" do
    it "has a valid factory" do
      build(:tournament).should be_valid
    end
    
    it "requires name" do
      build(:tournament, :name => nil).should_not be_valid
    end
    
    it "requires start date" do
      build(:tournament, :starts_at => nil).should_not be_valid
    end
    
    it "deletes all dependent signups when destroyed" do
      t = create(:tournament)
      create(:signup, :tournament => t)
      create(:signup, :tournament => t)
      
      t.destroy
      Signup.all.size.should == 0
    end
  end
end
