working_directory "/var/apps/scvrush.com/current"
pid "/var/apps/scvrush.com/shared/pids/unicorn.pid"
stderr_path "/var/apps/scvrush.com/shared/log/unicorn.log"
stdout_path "/var/apps/scvrush.com/shared/log/unicorn.log"

listen "/tmp/unicorn.scvrush.sock"
worker_processes 2
timeout 30

preload_app true