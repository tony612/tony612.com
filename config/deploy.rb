$:.unshift './lib'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)

require 'mina/defaults'
require 'mina/extras'
require 'mina/god'
require 'mina/unicorn'
require 'mina/nginx'
require 'mina/config'

Dir['lib/mina/servers/*.rb'].each { |f| load f }

###########################################################################
# Common settings for all servers
###########################################################################

set :app,                'tony612.com'
set :repository,         'git://github.com/tony612/tony612.com.git'
set :keep_releases,       10        #=> I like to keep all my releases
set :default_server,     :production

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp']

###########################################################################
# Tasks
###########################################################################

set :server, ENV['to'] || default_server
invoke :"env:#{server}"

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'         # I'm using MongoDB, not AR, so I don't need those
    invoke :'rails:assets_precompile'  # I don't really like assets pipeline

    to :launch do
      invoke :'unicorn:restart'
    end

    to :clean do
      queue 'log "failed deployment"'
    end
  end
end

