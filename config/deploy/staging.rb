set :rails_env, 'staging'
server "127.0.0.1", port: 10022, user: 'coronadonor-api_staging', roles: %w{web app db}
