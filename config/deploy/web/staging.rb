
set :application, 'staging.brewbit.com'

deploy_host = ENV['DEPLOY_HOST'] || fetch(:application)

role :app, %W{ deploy@#{deploy_host} }
role :web, %W{ deploy@#{deploy_host} }
role :db,  %W{ deploy@#{deploy_host} }

set :deploy_to, '/var/www/staging.brewbit.com'

set :rails_env, 'staging'
set :default_env, { rails_env: 'staging' }
