require 'spec_helper'

include SC2BC::API

describe SC2BC::API do

  describe "#login_via_form" do

    it "returns true on successful request" do
      token = "de914d907fe0dccdb67880d0b10b69081a8d290e"

      options = {
        name: "SCV Rush BSG #20",
        :begin => "2011-07-07T18:05:00+00:00",
        :end => "2012-01-01T00:00:00+00:00",
        registration_begin: "2011-07-05T13:05:00+00:00",
        registration_end: "2011-07-07T17:30:00+00:00",
        confirmation_begin: "2011-07-07T17:30:00+00:00",
        confirmation_end: "2011-07-07T17:55:00+00:00",
        tournament_type_id: "double-elimination"
      }


      res = SC2BC::API.post("https://darthdeus:#{token}@beta.sc2bc.com/api/tournament", options)
      binding.pry



    end

  end

end
