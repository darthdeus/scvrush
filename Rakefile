#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Scvrush::Application.load_tasks

unless Rails.env.production?
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new
  task default: :spec
end
