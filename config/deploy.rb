# -*- encoding : utf-8 -*-
require "bundler/capistrano"
require 'capistrano_colors'

server "server", :web, :app, :db, primary: true

set :application, "tree-example"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:Tolch/i#{application}.git"
set :branch, "master"
set :whenever_command, "bundle exec whenever"
require 'whenever/capistrano'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :cache do
  desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :clean do
    run("cd #{current_path}; /usr/bin/env rake cache:clean  RAILS_ENV=production")
  end
end

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  desc "Loading data into database."
  task :load_data, roles: :db do
    puts "Loading data into database using data.yml."
    run "cd #{current_path}; rake RAILS_ENV=production db:data:load"
  end
  after "deploy:migrate", "deploy:load_data"
end
