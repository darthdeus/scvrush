set :domain, "185.14.184.148"
set :branch, "ember-profiles"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

