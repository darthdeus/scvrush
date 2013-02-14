require "spec_helper"

describe "Tournaments" do

  describe "POST /tournaments" do

    it "responds with 200 and data for success" do
      post "/tournaments.json", tournament: { name: "foo", starts_at: 1.hour.from_now }
      response.status.should == 201
    end

    it "responds wiht 422 for failed validation" do
      post "/tournaments.json", tournament: { starts_at: 1.hour.from_now }
      response.status.should == 422
    end
  end

end
