require 'rvm/capistrano'

set :rvm_ruby_string, 'ruby-2.0.0-preview1'
set :rvm_type, :user

set :app_server, 'tony612.com'
set :app_url, 'http://tony612.com'

set :application, "tony612.com"
set :repository,  "git@github.com:tony612/tony612.com.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
default_run_options[:pty] = true

# using Agent Forwarding
set :ssh_options, { :forward_agent => true }

#In most cases you want to use this option, otherwise each deploy will do a full repository clone every time.
set :deploy_via, :remote_cache

# If you're using git submodules you must tell cap to fetch them.
set :git_enable_submodules, 1

set :branch, "master"

# bundler bootstrap Running cap deploy will now automatically run bundle install on the remote server with deployment-friendly options. A list of options that can be changed is available in the help for the cap task. To see it, run cap -e bundle:install.
require 'bundler/capistrano'
role :web, app_server                          # Your HTTP server, Apache/etc
role :app, app_server                          # This may be the same as your `Web` server
role :db,  app_server, :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :deploy_to, "/var/www/ib5k-web"
set :deploy_via, :remote_cache
set :user, "tony"
set :use_sudo, false

# # Multi stage
# # https://github.com/capistrano/capistrano/wiki/2.x-Multistage-Extension
# # https://github.com/VinceMD/Scem/wiki/Deploying-on-production
# require gem 'capistrano-ext'
# require 'capistrano/ext/multistage'
# set :stages, %w(production staging)
# set :default_stage, "staging" # require config/deploy/staging.rb

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# # integrate whenever
# # when using bundler
# set :whenever_command, "bundle exec whenever"
# # when using different environments
# set :whenever_environment, defer { stage }
# require "whenever/capistrano"
# # https://github.com/javan/whenever/blob/master/lib/whenever/capistrano.rb

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    %w{database}.each do |file|
      run "ln -nfs #{shared_path}/config/#{file}.yml #{release_path}/config/#{file}.yml"
    end

    # link dirs in public/
    %w{uploads}.each do |dir|
      run "mkdir -p #{shared_path}/public/#{dir}"
      run "ln -nfs #{shared_path}/public/#{dir} #{release_path}/public/#{dir}"
    end
  end

  desc "Initialize configuration using example files provided in the distribution"
  task :upload_config do
    %w{config}.each do |dir|
      run "mkdir -p #{shared_path}/#{dir}"
    end

    Dir["config/*.yml.example"].each do |file|
      top.upload(File.expand_path(file), "#{shared_path}/config/#{File.basename(file, '.example')}")
    end
  end
end

after 'deploy:setup', 'deploy:upload_config'
after 'deploy:update_code', 'deploy:symlink_shared'

namespace :deploy do
  desc 'Visit the app'
  task :visit_web do
    system "open #{app_url}"
  end
end
after 'deploy:restart', 'deploy:visit_web'

namespace :db do

  desc "Create db for current env"
  task :create do
    run "cd #{current_path}; bundle exec rake db:create RAILS_ENV=#{rails_env}"
    puts 'could be able to run `cap deploy:migrate` now'
  end

  desc "Populates the Production Database"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

end

# http://guides.rubyonrails.org/asset_pipeline.html#precompiling-assets
# https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy/assets.rb
load 'deploy/assets' unless ARGV.join == "deploy:update"
# then we got these tasks:
# cap deploy:assets:clean      # Run the asset clean rake task.
# cap deploy:assets:precompile # Run the asset precompilation rake task.

namespace :remote do
  desc "Open the rails console on one of the remote servers"
  task :console, :roles => :app do
    hostname = find_servers_for_task(current_task).first
    command = "cd #{current_path} && bundle exec rails console #{fetch(:rails_env)}"
    if fetch(:rvm_ruby_string)
      # set rvm shell and get ride of "'"
      # https://github.com/wayneeseguin/rvm/blob/master/lib/rvm/capistrano.rb
      # default_shell == "rvm_path=$HOME/.rvm/ $HOME/.rvm/bin/rvm-shell '1.9.2-p136'"
      rvm_shell = %{rvm_path=$HOME/.rvm/ $HOME/.rvm/bin/rvm-shell "#{fetch(:rvm_ruby_string)}"}
      command = %{#{rvm_shell} -c "#{command}"}
    else
      command = %{source ~/.profile && "#{command}"}
    end
    exec %{ssh -l #{user} #{hostname} -t '#{command}'}
  end

  desc 'run rake task. e.g.: `cap remote:rake db:version`'
  task :rake do
    ARGV.values_at(Range.new(ARGV.index('remote:rake')+1,-1)).each do |rake_task|
      top.run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake #{rake_task}"
    end
    exit(0)
  end

  desc 'run remote command. e.g.: `cap remote:run "tail -n 10 log/production.log"`'
  task :run do
    command=ARGV.values_at(Range.new(ARGV.index('remote:run')+1,-1))
    top.run "cd #{current_path}; RAILS_ENV=#{rails_env} #{command*' '}"
    exit(0)
  end

  desc 'run specified rails code on server. e.g.: `cap remote:runner p User.all` or `cap remote:runner "User.all.each{ |u| p u }"`'
  task :runner do
    command=ARGV.values_at(Range.new(ARGV.index('remote:runner')+1,-1))
    top.run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rails runner '#{command*' '}'"
    exit(0)
  end

  desc 'tail log on remote server'
  task :tail_log do
    top.run "tail -f #{current_path}/log/#{rails_env}.log" do |channel, stream, data|
      puts "#{data}"
      break if stream == :err
    end
    exit(0)
  end
end


# namespace :app do
#   desc 'recreate versions for photos'
#   task :recreate_versions_photos, :roles => :app do
#     codes = 'Photo.all.map {|p| p.image.recreate_versions! }'
#     ARGV = ["remote:runner", codes]
#     remote.runner
#   end
# end


# for backup db:
# https://github.com/webficient/capistrano-recipes
# gem install capistrano-recipes
# require 'capistrano_recipes'
# cap deploy:setup_dirs        # |DarkRecipes| Create shared dirs
# cap db:mysql:dump            # Performs a compressed database dump
# cap db:mysql:fetch_dump      # Downloads the compressed database dump to this machine


# Tips
# setup dir
# run `cap deploy:setup` to init dirs on remote server
# run `cap deploy:check` should see "You appear to have all necessary dependencies installed"

# setup db
# run `cap deploy:update`
# run `cap db:create` to create the db if necessary

# run `cap deploy:migrate` for first migration
# then for usual deploy, just run:
# run `cap deploy:migrations` Deploy and run pending migrations.
# or
# run `cap deploy` Deploy without running migrations.

# get version via cap:
# cap COMMAND="cd /var/www/#{app_server}/current; bundle exec rake db:version RAILS_ENV=production" invoke

# run `cap -T` or `cap -vT` to see more tasks info

