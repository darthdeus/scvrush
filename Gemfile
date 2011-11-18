source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'jquery-rails'
gem 'bcrypt-ruby', :require => 'bcrypt'

gem 'will_paginate', '> 3.0'
gem 'coffee-rails', '~> 3.1.1'
gem 'mysql2'
gem 'high_voltage'

gem 'unicorn'
gem 'capistrano'
gem 'slim-rails'

# find an alternative, https://github.com/bbatsov/rails-style-guide#flawed
gem 'therubyracer', :group => :production

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'nifty-generators'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
  gem 'launchy'
  
  group :darwin do
    gem 'rb-fsevent', :require => false
    gem 'rb-inotify', :require => false
    gem 'rb-fchange', :require => false
  end
  gem 'guard-rspec', :require => false
  gem 'guard-spork', :require => false
  gem 'growl'
  gem 'spork', '> 0.9.0.rc'
end


