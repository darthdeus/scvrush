require "spec_helper"

describe PostsHelper do

  let(:prague_tz) { ActiveSupport::TimeZone.new("Europe/Prague") }
  let(:date) { Time.zone.local(2012, 1, 1, 0, 0, 0) }

  describe "#nice_date" do
    before { Time.zone = "GMT" }

    it "returns formatted date for a user with timezone" do
      user = stub(time_zone: prague_tz)
      nice_date(date, user).should == "Sunday Jan 1st,  1:00am"
    end

    it "returns GMT if the user doesn't have a time zone" do
      user = stub(time_zone: nil)
      nice_date(date, user).should == "Sunday Jan 1st, 12:00am GMT"
    end

    it "returns GMT if there is no user" do
      nice_date(date, nil).should == "Sunday Jan 1st, 12:00am GMT"
    end

  end

end
