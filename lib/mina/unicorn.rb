###########################################################################
# Unicorn Tasks
###########################################################################

namespace :unicorn do
  desc "Upload and update (link) all Unicorn config files"
  task :update => [:upload, :link]

  desc "Relocate unicorn script file"
  task :link do
    invoke :sudo
    queue 'echo "-----> Relocate unicorn script file"'
    queue echo_cmd %{sudo cp "#{config_path}/unicorn.sh" "#{unicorn_script}" && sudo chown #{unicorn_user}:#{unicorn_group} #{unicorn_script} && sudo chmod u+x #{unicorn_script}}
    queue check_ownership unicorn_user, unicorn_group, unicorn_script
  end

  desc "Parses all Unicorn config files and uploads them to server"
  task :upload => [:'upload:config', :'upload:script']
  
  namespace :upload do
    desc "Parses Unicorn config file and uploads it to server"
    task :config do
      upload_template 'Unicorn config', 'unicorn.rb', "#{config_path}/unicorn.rb"
    end

    desc "Parses Unicorn control script file and uploads it to server"
    task :script do
      upload_template 'Unicorn control script', 'unicorn.sh', "#{config_path}/unicorn.sh"
    end
  end

  desc "Parses all Unicorn config files and shows them in output"
  task :parse => [:'parse:config', :'parse:script']
  
  namespace :parse do
    desc "Parses Unicorn config file and shows it in output"
    task :config do
      puts "#"*80
      puts "# unicorn.rb"
      puts "#"*80
      puts erb("#{config_templates_path}/unicorn.rb.erb")
    end

    desc "Parses Unicorn control script file and shows it in output"
    task :script do
      puts "#"*80
      puts "# unicorn.sh"
      puts "#"*80
      puts erb("#{config_templates_path}/unicorn.sh.erb")
    end
  end

  desc "Start unicorn"
  task :start do
    queue 'echo "-----> Start Unicorn"'
    queue echo_cmd "#{unicorn_script} start"
  end

  desc "Stop unicorn"
  task :stop do
    queue 'echo "-----> Stop Unicorn"'
    queue echo_cmd "#{unicorn_script} stop"
  end

  desc "Restart unicorn using 'upgrade'"
  task :restart do
    queue 'echo "-----> Restart Unicorn"'
    queue echo_cmd "#{unicorn_script} upgrade"
  end

end
