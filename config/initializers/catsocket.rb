require "catsocket_client/publisher"

CATSOCKET_PRODUCTION = false

if CATSOCKET_PRODUCTION
  CATSOCKET_API_KEY = "1053424174bca9fa8e7f3324abac29a5c0639fb0dcdd00120f3207bfb47feb0b"
  CS = CatsocketClient::Publisher.new("http://catsocket.com:5000", CATSOCKET_API_KEY)
else
  CATSOCKET_API_KEY = "123456"
  CS = CatsocketClient::Publisher.new("http://localhost:5000", CATSOCKET_API_KEY)
end
