require 'rubygems'
require 'spork'
require 'simplecov'
SimpleCov.start 'rails'

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
    config.before(:each) { reset_email }
    
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end
    
    config.before(:each) do
      DatabaseCleaner.start
    end
    
    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  # TODO - check if controllers and helpers are reloaded
  
  require 'factory_girl_rails'
  
  # reload all the models
  Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
    load model
  end

  # # reload all factories
  # Dir["#{Rails.root}/spec/factories/*.rb"].each do |factory|
  #   load factory
  # end
  
  Scvrush::Application.reload_routes!
end

