require 'spec_helper'

describe TopicsController do

  def assigns_should_match(h)
    h.each { |k,v| assigns[k].should == v }
  end

  describe "#new" do
    it "buildes a new section" do
      pending "https://gist.github.com/484282"
      section = stub_chain(:topics, :build).and_return(:new_topic)
      Section.should_receive(:find).with("1").and_return(section)

      get :new, section_id: 1
      assigns_should_match section: section, topic: :new_topic
    end
  end

  specify :create do
    @section = mock_model(Section)
    Section.stub!(:find).with("1").and_return(@section)

    post :create, 'topic[section_id]' => 1
  end

end
