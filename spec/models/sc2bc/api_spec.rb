require 'spec_helper'

describe SC2BC::API do

  include SC2BC::API

  describe "#login_via_form" do

    it "returns true on successful request" do
      token = "de914d907fe0dccdb67880d0b10b69081a8d290e"

      options = {
        name: "SCV Rush BSG #20",
        begin: "2011-07-07T18:05:00+00:00",
        end: "-0001-11-30T00:00:00+00:00",
        registration_begin: "2011-07-05T13:05:00+00:00",
        registration_end: "2011-07-07T17:30:00+00:00",
        confirmation_begin: "2011-07-07T17:30:00+00:00",
        confirmation_end: "2011-07-07T17:55:00+00:00"
      }
    end

  end

end
