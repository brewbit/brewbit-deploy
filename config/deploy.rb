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


namespace :services do

  desc "Restart all the services"
  task :restart do
    run "#{sudo} restart #{application}"
  end

  desc "Wipe and recreate the upstart scripts - (also restarts the services)"
  task :reinstall do

    raise "STOP!!!" if application.nil?

    begin
      run "#{sudo} stop #{application}"
    rescue
      # don't care if we can't stop. just means it wasn't running
    end

    run "#{sudo} rm -f /etc/init/#{application}*"

    run "cd #{current_path}; #{sudo} bundle exec foreman export upstart /etc/init -a #{application} -f #{current_path}/Procfile.#{stage} -u #{user} -c app=1"

    # Insert command to start service at boot time NOTE this does not work on the mac version of sed which is not GNU sed
    run "#{sudo} sed -i '1 i start on runlevel [2345]' /etc/init/#{application}.conf"
    run "#{sudo} start #{application}"
  end

  after "deploy:update", "deploy:services:reinstall"
end
