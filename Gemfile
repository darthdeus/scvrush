source 'http://rubygems.org'

gem 'rails', '3.1.1'

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'bcrypt-ruby', :require => 'bcrypt'

gem 'pg', :group => :production

group :development, :test do
  gem 'sqlite3'
  gem 'nifty-generators'
  gem 'rspec-rails'
  group :darwin do
    gem 'rb-fsevent', :require => false
    gem 'rb-inotify', :require => false
    gem 'rb-fchange', :require => false
  end
  gem 'guard-rspec', :require => false
  gem 'guard-spork', :require => false
  gem 'growl'
  gem 'spork', '> 0.9.0.rc'
  gem 'cucumber-rails'  
  gem 'database_cleaner'
  gem 'webrat'
  gem 'capybara'
  gem 'factory_girl_rails'
end


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

