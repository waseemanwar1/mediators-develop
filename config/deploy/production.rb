set :stage, :production
set :branch,    'master'

server '142.93.11.131', user: 'deploy', roles: [:web, :app, :db]
