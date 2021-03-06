# -*- encoding : utf-8 -*-
root = "/home/deployer/apps/tree-example/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.tree-example.sock"
worker_processes 5
timeout 30
