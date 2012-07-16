namespace :cache do
  desc "Deleting all caches"
  task :clean do
    puts 'Deleting index.html'
    sh %{rm -f public/index.html}
    puts'Deleting categories cache pages'
    sh %{rm -fr public/categories}
    puts'Deleting companies cache pages'
    sh %{rm -fr public/companies}
    sh %{rm -f public/companies.html}
    puts 'flush memcached'
    sh %{echo "flush_all" | /bin/netcat -q 2 127.0.0.1 11211}
  end
end
