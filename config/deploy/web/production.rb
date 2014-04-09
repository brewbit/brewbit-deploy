
set :application, 'brewbit.com'

role :app, %w{deploy@brewbit.com}
role :web, %w{deploy@brewbit.com}
role :db,  %w{deploy@brewbit.com}

set :deploy_to, '/var/www/brewbit.com'

set :rails_env, 'production'
set :default_env, { rails_env: 'production' }
