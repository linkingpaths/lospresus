#############################################################
# Settings
#############################################################

set :rails_env, "production"
set :application, "lospresus"

set :deploy_to, "/home/lospresus/#{application}_app"
set :keep_releases, 5

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true

#############################################################
# Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'linkingpaths'
set :repository, "git://github.com/linkingpaths/lospresus.git"
set :deploy_via, :remote_cache


#############################################################
# Servers
#############################################################

set :user, "lospresus"
set :domain, "lospresus.de"
server domain, :app, :web
role :db, domain, :primary => true


#############################################################
# => Passenger
#############################################################

namespace :deploy do

  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end