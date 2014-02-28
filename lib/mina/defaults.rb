###########################################################################
# Sensible defaults. You wouldn't want to change those in most of the cases
###########################################################################
task :defaults do
  set_default :term_mode,       :pretty
  set_default :rails_env,       'production'
  set_default :shared_paths,    ['tmp', 'log', 'public/system'] # last one is for paperclip
  set_default :branch,          'master'
  set_default :rvm_string,      nil
  set_default :rvm_path,        nil

  set_default :sockets_path,    "#{deploy_to}/#{shared_path}/tmp/sockets"
  set_default :pids_path,       "#{deploy_to}/#{shared_path}/tmp/pids"
  set_default :logs_path,       "#{deploy_to}/#{shared_path}/log"
  set_default :config_templates_path, "lib/mina/templates"
  set_default :local_config_path, "config"
  set_default :config_path,     "#{deploy_to}/#{shared_path}/config"

  set_default :god_script,      "#{services_path!}/god"
  set_default :god_global,      "#{config_path}/global.god"
  set_default :god_unicorn,     "#{config_path}/god/unicorn.god"
  set_default :god_bin,         "#{deploy_to}/#{current_path}/bin/god"
  set_default :god_user,        user
  set_default :god_group,       user

  set_default :unicorn_socket,  "#{sockets_path}/unicorn.sock"
  set_default :unicorn_pid,     "#{pids_path}/unicorn.pid"
  set_default :unicorn_config,  "#{config_path}/unicorn.rb"
  set_default :unicorn_script,  "#{services_path!}/unicorn-#{app!}"
  set_default :unicorn_workers, 1
  # set_default :unicorn_bin,   'bundle exec unicorn' # you may prefer this over the line below
  set_default :unicorn_bin,     "#{deploy_to}/#{current_path}/bin/unicorn_rails"
  set_default :unicorn_user,    user
  set_default :unicorn_group,   user

  set_default :nginx_config,    "#{nginx_path}/sites-available/#{app!}.conf"
  set_default :nginx_config_e,  "#{nginx_path}/sites-enabled/#{app!}.conf"
  set_default :nginx_log_path,  "#{deploy_to}/#{shared_path}/log/nginx"
  set_default :nginx_user,      "www-data"
  set_default :nginx_group,     "www-data"
  set_default :nginx_server_name, domain
end
