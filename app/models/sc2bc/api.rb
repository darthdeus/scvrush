module SC2BC

  module API

    PREFIX = "https://beta.sc2bc.com/api"
    LOGIN = "https://beta.sc2bc.com/user/sign/in?do=signInForm-submit"

    class ResourceNotFound < Exception; end
    class InternalServerError < Exception; end
    class BadRequest < Exception; end

    class << self

      # Perform a GET request to a given URL
      def get(url)
        Rails.logger.info "GET #{url}"
        response = self.with_handlers { JSON.parse(RestClient.get(url)) }
        Rails.logger.info "response: #{response}"

        return response
      end

      # Perform a POST request to a given URL
      def post(url, data)
        Rails.logger.info "POST #{url} #{data.to_json}"
        response = self.with_handlers { JSON.parse(RestClient.post(url, data)) }
        Rails.logger.info "response: #{response}"

        return response
      end

      # Perform a PUT request to a given URL
      def put(url, data)
        Rails.logger.info "PUT #{url} #{data}"
        response = self.with_handlers { JSON.parse(RestClient.put(url, data)) }
        Rails.logger.info "response: #{response}"

        return response
      end

      # Perform a DELETE request to a given URL
      def delete(url)
        Rails.logger.info "DELETE #{url}"
        response = self.with_handlers { JSON.parse(RestClient.delete(url)) }
        Rails.logger.info "response: #{response}"

        return response
      end

      # Execute a block of code with general exception handlers for requests
      def with_handlers(&block)
        yield
      rescue RestClient::ResourceNotFound => e
        raise ResourceNotFound, e.message
      rescue RestClient::BadRequest => e
        raise BadRequest, e.message
      rescue RestClient::InternalServerError => e
        raise InternalServerError, e.message
      end

      def login_via_form(username, password)
        self.post(LOGIN, { username: username, password: password })
      end

      # Create a new tournament and return it's ID
      #
      # {
      #   name: "SCV Rush BSG #20",
      #   begin: "2011-07-07T18:05:00+00:00",
      #   end: "-0001-11-30T00:00:00+00:00",
      #   registration_begin: "2011-07-05T13:05:00+00:00",
      #   registration_end: "2011-07-07T17:30:00+00:00",
      #   confirmation_begin: "2011-07-07T17:30:00+00:00",
      #   confirmation_end: "2011-07-07T17:55:00+00:00"
      # }
      def create_tournament(options)
        # TODO - options must contain the token
        response = self.post "#{PREFIX}/tournament", options
      end

      # Set players for a given tournament
      #
      # tournament - id of the tournament
      # players    - an Array of players, such as
      #        [{
      #          email: "foobar@example.com",
      #          code: 222,
      #          name: "foobar"
      #         }, ...]
      def set_players(tournament, players)
        data = {
          players: players.to_json,
          username: @username,
          token: @token,
          id: tournament
        }
        RestClient.post "#{PREFIX}/tournament/set_players", data
      end

      # Delete a tournament for a given ID
      def destroy_tournament(id)
        RestClient.delete "#{PREFIX}/tournament/#{id}"
      end

      # Start a given tournament
      def start
        RestClient.post "#{PREFIX}/tournament/start"
      end

    end

  end
end
