require 'rvm/capistrano'

set :domain, "scvrush.com"
set :branch, "master"

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :system

role :web, domain
role :app, domain
role :db,  domain, :primary => true

