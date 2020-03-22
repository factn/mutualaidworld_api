# config valid for current version and patch releases of Capistrano
lock "~> 3.12.1"
set :application, "coronadonor-api"
#set :repo_url, "git@github.com:factn/coronadonor-api.git"
set :repo_url, "https://github.com/factn/coronadonor-api.git"

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :deploy_to, "/home/coronadonor-api_#{fetch(:stage)}/"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
