set :output, {:error => 'log/cron_error.log', :standard => 'log/cron.log'}
every 5.minutes do
  runner "FeedEntry.update_from_feed"
end

every 1.day, :at => '4:30 am' do
  runner "FeedEntry.delete_all"
end


every :friday, :at => '6:00 am' do
  rake "cache:delete_all_cache"
end
