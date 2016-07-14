set :user, :deploy
set :password, 'ftSdwa4w'

set :deploy_to, '/data/ash'

server 'ash.fabianoudhaarlem.nl', user: fetch(:user), password: fetch(:password), roles: %w{web app db}

set :stage, :staging

set :branch, 'staging'
set :env, 'staging'
