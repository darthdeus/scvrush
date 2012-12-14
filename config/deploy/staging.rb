set :domain, "beta.scvrush.com"
set :branch, "ember-profiles"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

