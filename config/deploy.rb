require 'bundler/capistrano'

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "scvrush.com"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :repository,  "git@github.com:darthdeus/scvrush.git"
set :scm, :git

set :user,      "deploy"
set :runner,    user
set :rails_env, "production"
set :use_sudo,  false

set :deploy_to, "/var/apps/#{application}"
set :deploy_via, :remote_cache

namespace :deploy do

  task :start, :roles => :app, :except => { :no_release => true } do
    run "/etc/init.d/unicorn_scvrush start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "/etc/init.d/unicorn_scvrush stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "/etc/init.d/unicorn_scvrush restart"
    # run "#{try_sudo} service unicorn stop"
    # run "cd #{current_path}; bundle exec ./bin/unicorn -D -c config/unicorn.rb -E production"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml  #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/mongoid.yml   #{release_path}/config/mongoid.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml  #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/bin/unicorn #{release_path}/bin/unicorn"
  end

  # recompile assets only if needed
  namespace :assets do
    task :precompile, roles: :web, except: { no_release: true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} -- vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=production #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

end


before "deploy:assets:precompile", "deploy:symlink_shared"
