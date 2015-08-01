server '104.155.32.122', user: 'dunyakirkali', roles: %w(app db web)

set :stage, :staging
set :rails_env, 'staging'
set :puma_env, 'production'
set :nginx_domains, 'staging.kauntaa.com'
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma-#{fetch :application}.sock"
set :app_server_socket, "#{shared_path}/tmp/sockets/puma-#{fetch :application}.sock"

after 'deploy:finished', 'deploy:seed'
