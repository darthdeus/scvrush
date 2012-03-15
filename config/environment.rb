# Load the rails application
require File.expand_path('../application', __FILE__)

if RUBY_VERSION > '1.8.7'
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

# Initialize the rails application
Scvrush::Application.initialize!
