namespace :cache do
  desc "Deleting all caches"
  task :clean do
    puts 'flush memcached'
    sh %{echo "flush_all" | /bin/netcat -q 2 127.0.0.1 11211}
  end
end
