# config valid only for Capistrano 3.1
lock '3.1.0'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{.env}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

# Default value for keep_releases is 5
# set :keep_releases, 5

set :ssh_options, {
  keys: %w(~/.ssh/brewbit ~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}
