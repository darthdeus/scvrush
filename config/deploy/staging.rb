set :domain, "beta.scvrush.com"
set :branch, "develop"

role :web, domain
role :app, domain
role :db,  domain, primary: true

