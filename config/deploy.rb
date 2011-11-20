require "bundler/capistrano"
require 'new_relic/recipes'

set :application, "scvrush.com"
set :domain, "scvrush.xen.prgmr.com"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :repository,  "git@github.com:darthdeus/scvrush.git"
set :scm, :git
set :branch, "master"

set :user, "deploy"
set :runner, user
set :rails_env, "production"
# set :use_sudo, false


set :deploy_to, "/var/apps/#{application}"
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true

# 
# working_directory "/var/apps/scvrush.com/current"
# pid "/var/apps/scvrush.com/shared/pids/unicorn.pid"
# stderr_path "/var/apps/scvrush.com/shared/log/unicorn.log"
# stdout_path "/var/apps/scvrush.com/shared/log/unicorn.log"
# set :rails_env, :production

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "#{try_sudo} service unicorn start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "#{try_sudo} service unicorn stop"    
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} service unicorn restart"
  end
  
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end

  after 'deploy:update_code', 'deploy:symlink_shared'
  after 'deploy:update_code', 'deploy:pipeline_precompile'
end

after "deploy:update", "newrelic:notice_deployment"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end