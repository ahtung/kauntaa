lock '3.4.0'

set :application, 'kauntaa'
set :repo_url, 'git@github.com:dunyakirkali/kauntaa.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/kauntaa'

set :rvm_type, :system
set :rvm_ruby_version, '2.1.2'
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :foreman_env,  '/var/www/kauntaa/shared/config/.env'

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

namespace :deploy do
  desc 'Run seeds'
  task :seed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export do
    on roles(:app) do
      within release_path do
        execute "cd /var/www/kauntaa/current && sudo /usr/local/rvm/wrappers/ruby-2.1.2@global/bundle exec foreman export supervisord /etc/supervisor/conf.d \
          -f ./Procfile \
          -e /var/www/kauntaa/shared/config/.env \
          -a #{fetch(:application)} \
          -u deployer \
          -l /var/www/kauntaa/shared/log"
      end
    end
  end

  desc "Stop for supervisor processes"
  task :stop do
    on roles(:app) do
      execute "sudo supervisorctl stop #{fetch(:application)}:*"
    end
  end

  desc "Reread for supervisor control"
  task :reread do
    on roles(:app) do
      execute "sudo supervisorctl reread"
    end
  end

  desc "Update for supervisor control"
  task :update do
    on roles(:app) do
      execute "sudo supervisorctl update"
    end
  end
end

# after "deploy:started", "foreman:stop"
after "deploy:finished", "foreman:export"
after "deploy:finished", "foreman:reread"
after "deploy:finished", "foreman:update"
