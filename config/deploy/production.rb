server "104.155.2.29", user: "dunyakirkali", roles: %w(app db web)

set :stage, :production
set :rails_env, "production"
set :puma_env, "production"
set :nginx_server_name, "www.kauntaa.com kauntaa.com"
