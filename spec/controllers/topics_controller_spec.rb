require 'spec_helper'

describe TopicsController do
  
  describe "#new" do
    it "builds a topic with a given section" do
      @new_topic = mock_model(Topic)
      @topics = mock('topics')
      @topics.should_receive(:build).and_return(@new_topic)
    
      @section = mock_model(Section)
      @section.should_receive(:topics).and_return(@topics)
    
      Section.should_receive(:find).with("1").and_return(@section)
      get :new, :section_id => 1
    
      assigns[:topic].should == @new_topic
    end
  end
  
  describe "#show" do
    it "loads a topic by id" do
      @topic = mock_model(Topic)
      @topic.should_receive(:replies)
      
      @arel_mock = mock("find_result")
      Topic.should_receive(:includes).with(:replies).and_return(@arel_mock)
      @arel_mock.should_receive(:find).with("1").and_return(@topic)
      
      get :show, :id => 1
      
      assigns[:topic].should be(@topic)
    end
  end
  
  describe "#create" do
    it "creates new topic and reply based on given valid data" do
      @section = mock_model(Section)
      Section.should_receive(:find).with("1").and_return(@section)
      
      
      
      
    end
  end
end
