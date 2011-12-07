require 'spec_helper'

describe TournamentsController do
  it "#show" do
    @signups = mock_model(Signup)
    @signups.should_receive(:registered).and_return(:registered)
    @signups.should_receive(:checked).and_return(:checked)
    
    @tournament = mock_model(Tournament)
    @tournament.should_receive(:signups).twice.and_return(@signups)    
    
    Tournament.should_receive(:find).with("1").and_return(@tournament)
    get :show, :id => 1
    
    assigns[:tournament].should == @tournament
  end
end
