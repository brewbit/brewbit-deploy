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

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets}

# Default value for keep_releases is 5
# set :keep_releases, 5

set :ssh_options, {
  keys: %w(~/.ssh/brewbit ~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}

namespace :deploy do
  namespace :services do
  
    desc "Restart all the services"
    task :restart do
      execute :sudo, "restart #{fetch(:application)}"
    end
  
    desc "Wipe and recreate the upstart scripts - (also restarts the services)"
    task :reinstall do
      on roles(:all) do
        begin
          execute :sudo, "stop #{fetch(:application)}"
        rescue
          # don't care if we can't stop. just means it wasn't running
        end
    
        execute :sudo, "rm -f /etc/init/#{fetch(:application)}*"
    
        within release_path do
          execute :sudo, "bundle exec foreman export upstart /etc/init -a #{fetch(:application)} -f Procfile.#{fetch(:stage).split(':').last} -u deploy -c app=1"
        end
    
        # Insert command to start service at boot time NOTE this does not work on the mac version of sed which is not GNU sed
        execute :sudo, "sed -i '1 i start on runlevel [2345]' /etc/init/#{fetch(:application)}.conf"
        execute :sudo, "start #{fetch(:application)}"
      end
    end
  
    after "deploy:updated", "deploy:services:reinstall"
  end
end
