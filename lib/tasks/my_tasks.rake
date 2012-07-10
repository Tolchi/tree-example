namespace :cache do
  desc "Deleting all caches"
  task :delete_all_cache do
    puts 'Deleting index.html'
    sh %{rm -f public/index.html}
    puts'Deleting categories cache pages'
    sh %{rm -fr public/categories}
    puts'Deleting companies cache pages'
    sh %{rm -fr public/companies}
    sh %{rm -f public/companies.html}
  end
end
