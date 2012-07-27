working_directory "/var/apps/scvrush.com/current"
pid "/var/apps/scvrush.com/shared/pids/unicorn.pid"
stderr_path "/var/apps/scvrush.com/shared/log/unicorn.log"
stdout_path "/var/apps/scvrush.com/shared/log/unicorn.log"

listen "/tmp/unicorn.scvrush.sock"
worker_processes 4
timeout 30

application = "scvrush.com"
app_path = "/var/apps/#{application}"
bundle_path = "#{app_path}/shared/bundle"

before_exec do |_|
  paths = (ENV["PATH"] || "").split(File::PATH_SEPARATOR)
  paths.unshift "#{bundle_path}/bin"

  ENV["PATH"] = paths.uniq.join(File::PATH_SEPARATOR)
  ENV["GEM_HOME"] = ENV['GEM_PATH'] = bundle_path
  ENV["BUNDLE_GEMFILE"] = "#{app_path}/current/Gemfile"
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end

preload_app true
