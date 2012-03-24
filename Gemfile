source 'http://rubygems.org'

gem 'rails', '3.2.1'

gem 'jquery-rails'
gem 'bcrypt-ruby', :require => 'bcrypt'

gem 'coffee-rails'#, '~> 3.1.1'

gem 'mysql2'

gem 'slim-rails'
gem 'sass-rails'#,   '~> 3.1.4'

gem 'fog'
gem 'carrierwave', github: 'jnicklas/carrierwave'
gem 'mini_magick'
gem 'airbrake'

group :assets do
  gem 'uglifier'#, '>= 1.0.3'
end

# gem 'newrelic_rpm'

gem 'memcache-client'
# gem 'redis-store'
# gem "redis-rails", "~> 3.2.1.rc"

gem 'cancan'
gem 'rolify'

gem 'rdiscount'
gem 'activeadmin'#, '~> 0.4.0'
gem 'kaminari'

gem 'thumbs_up'
gem 'acts-as-taggable-on', '~>2.1.0'

# find an alternative, https://github.com/bbatsov/rails-style-guide#flawed
gem 'therubyracer', :group => :production
# gem 'mustang'

group :development, :test do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-nav'
end

group :test do
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'rspec-rails', '2.9'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'cucumber-rails', :require => false
  gem 'populator'
  gem 'faker'

  group :darwin do
    gem 'rb-fsevent', :require => false
    gem 'rb-inotify', :require => false
    gem 'rb-fchange', :require => false
  end
  gem 'spork', '> 0.9.0.rc'
  gem 'guard-rspec', :require => false
  gem 'guard-spork', :require => false
  gem 'guard-cucumber'

end

gem 'unicorn'

gem 'capistrano'

