require "bundler/capistrano"

set :application, "scvrush.com"
set :domain, "scvrush.xen.prgmr.com"

set :repository,  "git@github.com:darthdeus/scvrush.git"
set :scm, :git
set :branch, "master"

set :user, "deploy"
set :runner, user
set :rails_env, "production"
set :use_sudo, false


set :deploy_to, "/var/apps/#{application}"
set :deploy_via, :remote_cache

role :web, domain
role :app, domain
role :db,  domain, :primary => true



namespace :deploy do
  task :start do 
    run "touch #{current_path}/tmp/restart.txt"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    # run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end

  
  after 'deploy:update_code', 'deploy:pipeline_precompile'
  after 'deploy:update_code', 'deploy:symlink_shared'
  
end

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