
require 'capistrano/multiconfig'
require 'capistrano/deploy'
require 'capistrano/bundler'

# TODO - this is a total hack... There must be a better way...
config = Rake.application.top_level_tasks[0].split(':').first
if config == 'web'
  require 'capistrano/rails/assets'
  require 'capistrano/rails/migrations'
  require 'whenever/capistrano'
end

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
