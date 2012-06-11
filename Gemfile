source :rubygems

gem 'rails',        '3.2.2'

gem 'jquery-rails', '~> 2.0.1'
gem 'bcrypt-ruby',  '~> 3.0.1', :require => 'bcrypt'

gem 'coffee-rails', '~> 3.2.2'

gem 'mysql2',       '~> 0.3.11'

gem 'slim-rails',   '~> 1.0.3'
gem 'sass-rails',   '~> 3.2.5'

gem 'fog',          '~> 1.3.0'
gem 'carrierwave', github: 'darthdeus/carrierwave', ref: "be594ea374a66be25e0cd63e58176987803ccbc4"
gem 'mini_magick',        '~> 3.4'
gem 'airbrake',           '~> 3.0.9'
gem 'bourbon',            '~> 1.4.0'

group :assets do
  gem 'uglifier',         '~> 1.2.3'
end

gem 'memcache-client',    '~> 1.8.5'
# gem 'redis-store'
# gem "redis-rails", "~> 3.2.1.rc"

gem 'cancan', '~> 1.6.7'
gem 'rolify', '~> 2.2.2'

gem 'rdiscount',           '~> 1.6.8'
gem 'activeadmin',         '~> 0.4.3'
gem 'kaminari',            '~> 0.13.0'

gem 'thumbs_up',           '~> 0.5.3'
gem 'acts-as-taggable-on', '~> 2.1.0'

gem 'rest-client',         '~> 1.6.7'
gem 'gon',                 '~> 2.3.0'

# find an alternative, https://github.com/bbatsov/rails-style-guide#flawed
gem 'therubyracer', :group => :production
# gem 'mustang'

group :development, :test do
  gem 'pry',        '~> 0.9.8.4'
  gem 'pry-doc',    '~> 0.4.1'
  gem 'pry-rails',  '~> 0.1.6'
  gem 'pry-nav',    '~> 0.2.0'
end

group :test do
  gem 'database_cleaner',   '~> 0.7.2'
  gem 'simplecov',          '~> 0.6.1'
  gem 'rspec-rails',        '~> 2.9.0'
  gem 'capybara',           '~> 1.1.2'
  gem 'capybara-webkit',    '~> 0.11.0'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'launchy',            '~> 2.1.0'
  gem 'cucumber-rails', :require => false
  gem 'populator',          '~> 1.0.0'
  gem 'faker',              '~> 1.0.1'

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

gem 'unicorn',        '~> 4.2.0'
gem 'capistrano',     '~> 2.11.2'
gem 'rvm-capistrano', '~> 1.0.2'

