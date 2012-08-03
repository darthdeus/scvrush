require 'rubygems'
require 'spork'
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter do |file|
    file.filename =~ %r{app/admin}
  end
end

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  require 'capybara/rspec'
  Capybara.javascript_driver = :webkit
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.include Factory::Syntax::Methods
    config.include MailerMacros
    config.include AuthMacros

    # config.before(:each) { reset_email }

    # config.before(:suite) do
    #   DatabaseCleaner.strategy = :truncation
    # end

    # config.before(:each) do
    #   DatabaseCleaner.start
    # end

    # config.after(:each) do
    #   DatabaseCleaner.clean
    # end
  end

  require 'factory_girl_rails'

end

Spork.each_run do
  # TODO - check if controllers and helpers are reloaded

  # reload all factories
  FactoryGirl.factories.clear
  Dir["#{::Rails.root}/spec/factories/**/*.rb"].each { |file| load file }

  Dir["#{Rails.root}/app/helpers/**/*.rb"].each     { |helper|     load helper }
  Dir["#{Rails.root}/app/controllers/**/*.rb"].each { |controller| load controller }
  Dir["#{Rails.root}/app/models/**/*.rb"].each      { |model|      load model }
  Dir["#{Rails.root}/app/decorators/**/*.rb"].each  { |model|      load model }

  Scvrush::Application.reload_routes!
end
