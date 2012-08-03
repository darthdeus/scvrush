source :rubygems

gem 'rails',        '~> 3.2.7'

gem 'jquery-rails', '~> 2.0.1'
gem 'bcrypt-ruby',  '~> 3.0.1', require: 'bcrypt'

gem 'coffee-rails',             '~> 3.2.2'

gem 'mysql2',                   '~> 0.3.11'
gem 'pg',                       '~> 0.14.0'

# Frontend
gem 'slim-rails',                '~> 1.0.3'
gem 'sass-rails',                '~> 3.2.5'
gem 'jquery-datatables-rails',   '~> 1.9.1.3'
gem 'bootstrap-sass',            '~> 2.0.3.1'
gem 'simple_form',               '~> 2.0.1'
gem 'bourbon',                   '~> 1.4.0'

gem 'rdiscount',          '~> 1.6.8'
gem 'kaminari',           '~> 0.13.0'

gem 'draper',             '~> 0.14.0'
# gem 'ruby-prof',          '~> 0.11.2'

gem 'fog',                '~> 1.3.0'
gem 'carrierwave', github: 'darthdeus/carrierwave', ref: "be594ea"
gem 'mini_magick',        '~> 3.4'
gem 'airbrake',           '~> 3.0.9'

group :assets do
  gem 'uglifier',         '~> 1.2.3'
end

gem 'memcache-client',    '~> 1.8.5'

# Role management
gem 'cancan', '~> 1.6.7'
gem 'rolify', '~> 2.2.2'

gem 'party_boy',            '~> 0.3.4'

gem 'acts-as-taggable-on',  '~> 2.1.0'

gem 'rest-client',          '~> 1.6.7'
gem 'gon',                  '~> 2.3.0'

# find an alternative, https://github.com/bbatsov/rails-style-guide#flawed
gem 'therubyracer', group: :production
# gem 'mustang'

group :development, :test do
  gem 'pry',        '~> 0.9.9'
  gem 'pry-doc',    '~> 0.4.2'
  gem 'pry-rails',  '~> 0.1.6'
  gem 'pry-nav',    '~> 0.2.1'

  gem 'rack-mini-profiler', '~> 0.1.6'

  gem 'populator',          '~> 1.0.0'
  gem 'faker',              '~> 1.0.1'
end

group :test do
  gem 'database_cleaner',   '~> 0.7.2'
  gem 'simplecov',          '~> 0.6.1'
  gem 'rspec-rails',        '~> 2.9.0'
  gem 'capybara',           '~> 1.1.2'
  gem 'capybara-webkit',    '~> 0.11.0'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'launchy',            '~> 2.1.0'
  gem 'cucumber-rails',     require: false

  gem 'spork', '> 0.9.0.rc'
end

gem 'unicorn',        '~> 4.3.1'
gem 'capistrano',     '~> 2.11.2'
gem 'rvm-capistrano', '~> 1.0.2'
