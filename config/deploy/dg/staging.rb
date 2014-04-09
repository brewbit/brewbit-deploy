
set :application, 'dg.staging.brewbit.com'

role :app, %w{deploy@dg.staging.brewbit.com}
role :web, %w{deploy@dg.staging.brewbit.com}
role :db,  %w{deploy@dg.staging.brewbit.com}

set :deploy_to, '/var/www/dg.staging.brewbit.com'

set :rails_env, 'staging'
set :default_env, { rails_env: 'staging' }
