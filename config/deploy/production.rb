set :rails_env, 'production'
server "127.0.0.1", port: 10022, user: 'coronadonor-api_production', roles: %w{web app db}
