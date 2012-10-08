require 'spec_helper'

describe TopicsController do

  def assigns_should_match(h)
    h.each { |k,v| assigns[k].should == v }
  end

  specify :new do
    # TODO - is there a better way to write a stub_chain?
    # https://gist.github.com/484282
    section = mock(Section)
    section.stub_chain(:topics, :build).and_return(:new_topic)
    Section.should_receive(:find).with("1").and_return(section)

    get :new, section_id: 1
    assigns_should_match section: section, topic: :new_topic
  end

  context :create do

    it "creates a Topic and a Reply for valid data" do
      user = login
      section = create(:section)

      post :create, {
        section_id: section.id,
        topic: { name: 'topic name', content: 'topic content' }
      }

      json = JSON.parse(response.body)
      json["status"].should == "ok"
      json["location"].should == topic_path(Topic.last.to_param)
      Reply.last.content.should == 'topic content'
    end

  end

end
