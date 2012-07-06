# Load the rails application
require File.expand_path('../application', __FILE__)

if RUBY_VERSION > '1.8.7'
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end


# Initialize the rails application
Scvrush::Application.initialize!

# require 'ruby-prof'
#
# # Profile the code
# RubyProf.start
# # THE CODE
# result = RubyProf.stop
#
# # Print a flat profile to text
# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT)
