set :domain, "beta.scvrush.com"
set :branch, "beta"

role :web, domain
role :app, domain
role :db,  domain, primary: true

