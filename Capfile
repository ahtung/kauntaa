require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/nginx'
require 'capistrano/puma'
require "whenever/capistrano"

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
