
set :application, 'brewbit.com'

deploy_host = ENV['DEPLOY_HOST'] || fetch(:application)

role :app, %W{ deploy@#{deploy_host} }
role :web, %W{ deploy@#{deploy_host} }
role :db,  %W{ deploy@#{deploy_host} }

set :deploy_to, '/var/www/brewbit.com'

set :rails_env, 'production'
set :default_env, { rails_env: 'production' }
