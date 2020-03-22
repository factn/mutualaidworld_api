server "127.0.0.1", port: 10022, user: 'coronadonor-api_development', roles: %w{web app db}
set :deploy_to, "/home/coronadonor-api_development/"
set :rails_env, 'staging'
