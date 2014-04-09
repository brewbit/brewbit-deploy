
set :application, 'dg.brewbit.com'

role :app, %w{deploy@dg.brewbit.com}
role :web, %w{deploy@dg.brewbit.com}
role :db,  %w{deploy@dg.brewbit.com}

set :deploy_to, '/var/www/dg.brewbit.com'

set :rails_env, 'production'
set :default_env, { rails_env: 'production' }
