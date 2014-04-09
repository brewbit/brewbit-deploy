
set :application, 'staging.brewbit.com'

role :app, %w{deploy@staging.brewbit.com}
role :web, %w{deploy@staging.brewbit.com}
role :db,  %w{deploy@staging.brewbit.com}

set :deploy_to, '/var/www/staging.brewbit.com'

set :rails_env, 'staging'
set :default_env, { rails_env: 'staging' }
