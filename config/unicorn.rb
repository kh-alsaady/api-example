# # set path to application
# app_dir = File.expand_path("../..", __FILE__)
# shared_dir = "#{app_dir}/shared"
# working_directory app_dir


# # Set unicorn options
# worker_processes 2
# preload_app true
# timeout 30

# # Set up socket location
# listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# # Logging
# stderr_path "#{shared_dir}/log/unicorn.stderr.log"
# stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# # Set master PID location
# pid "#{shared_dir}/pids/unicorn.pid"


root = "/var/www/html/api_examples/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen 3055
worker_processes 1
timeout 30
