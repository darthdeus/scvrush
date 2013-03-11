require "catsocket_client/publisher"

if Rails.env.production?
  CS = CatsocketClient::Publisher.new("http://catsocket.com:5000", "0")
else
  CS = CatsocketClient::Publisher.new("http://localhost:5100", "0")
end
