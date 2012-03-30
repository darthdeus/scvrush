$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# require 'rvm/capistrano'
require 'bundler/capistrano'
# require 'new_relic/recipes'

set :application, "scvrush.com"
# set :domain, "scvrush.com"
set :domain, "97.107.142.61"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :repository,  "git@github.com:darthdeus/scvrush.git"
set :scm, :git
set :branch, "master"

set :user, "deploy"
set :runner, user
set :rails_env, "production"
set :use_sudo, false

set :rvm_ruby_string, '1.9.2@scvrush'
set :rvm_type, :system

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

  # task :cold do
  #   update
  #   load_schema
  #   start
  # end

  # task :load_schema, :roles => :app do
  #   run "cd #{current_path}; RAILS_ENV=production rake db:schema:load"
  # end

  task :start, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} service unicorn start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} service unicorn stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    # run "#{try_sudo} service unicorn restart"
    # TODO - this needs to be fixed to work via the init script
    run "#{try_sudo} service unicorn stop"
    run "cd #{current_path}; bundle exec ./bin/unicorn -D -c config/unicorn.rb -E production"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/bin/unicorn #{release_path}/bin/unicorn"
  end

  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end

end


namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

# TODO - make this cleaner
before "deploy:assets:precompile", "deploy:symlink_shared"

before "deploy:finalize_update", "rvm:trust_rvmrc"
# after "deploy:update", "newrelic:notice_deployment"



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


# slows down deploys, fix?
# require './config/boot'
# require 'airbrake/capistrano'
