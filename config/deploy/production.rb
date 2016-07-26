set :user, :deploy
set :password, 'ftSdwa4w'

set :deploy_to, '/data/ash-production'

server 'ash-production.fabianoudhaarlem.nl', user: fetch(:user), password: fetch(:password), roles: %w{web app db}

set :stage, :production

set :branch, 'master'
set :env, 'production'
