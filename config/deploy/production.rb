server "104.155.2.29", user: "dunyakirkali", roles: %w(app db web)

set :stage, :production
set :rails_env, "production"
set :puma_env, "production"
set :nginx_domains, "www.kauntaa.com kauntaa.com"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma-#{fetch :application}.sock"
set :app_server_socket, "#{shared_path}/tmp/sockets/puma-#{fetch :application}.sock"
