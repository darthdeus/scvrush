require 'rvm/capistrano'
require 'bundler/capistrano'

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

set :rvm_ruby_string, '1.9.2'
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

  task :start, :roles => :app, :except => { :no_release => true } do
    run "/etc/init.d/unicorn start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "/etc/init.d/unicorn stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    # TODO - this needs to be fixed to work via the init script
    run "/etc/init.d/unicorn restart"
    # run "#{try_sudo} service unicorn stop"
    # run "cd #{current_path}; bundle exec ./bin/unicorn -D -c config/unicorn.rb -E production"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/bin/unicorn #{release_path}/bin/unicorn"
  end

  # recompile assets only if needed
  namespace :assets do
    task :precompile, roles: :web, except: { no_release: true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} -- vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

end


before "deploy:assets:precompile", "deploy:symlink_shared"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# slows down deploys, fix?
# require './config/boot'
# require 'airbrake/capistrano'
