require 'bundler/capistrano'

set :application, "scvrush"
set :domain, "scvrush.com"
set :branch, "master"

role :web, domain
role :app, domain
role :db,  domain, primary: true


default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :repository,  "git@github.com:darthdeus/scvrush.git"
set :scm, :git

set :user,      "deploy"
set :runner,    user
set :rails_env, "production"
set :use_sudo,  false

set :deploy_to, "/opt/apps/#{application}"
set :deploy_via, :remote_cache


set :default_environment, {
    "PATH" => "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH"
}

namespace :deploy do

  task :start do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec unicorn -D -c config/unicorn.rb -E production"
  end

  task :stop do
    run "cd #{current_path} && kill $(cat tmp/pids/unicorn.pid)"
  end

  task :restart do
    stop
    start
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/s3.yml  #{release_path}/config/s3.yml"
    run "ln -nfs #{shared_path}/config/database.yml  #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/newrelic.yml  #{release_path}/config/newrelic.yml"
    run "ln -nfs #{shared_path}/config/unicorn.rb  #{release_path}/config/unicorn.rb"
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
