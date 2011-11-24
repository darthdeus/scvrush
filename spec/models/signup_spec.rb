require 'spec_helper'

describe Signup do
  
  it "has default value of REGISTERED" do
    create(:signup, :status => nil).status == Signup::REGISTERED
  end
  
  describe "#checkin" do    
    it "sets status to checked" do
      signup = create(:signup)
      signup.checkin!
      signup.status.should == Signup::CHECKED
    end
  end
  
end
