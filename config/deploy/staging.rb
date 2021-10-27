set :stage,   :staging
set :branch,  ''

server '', user: 'deploy', roles: [:web, :app, :db]
