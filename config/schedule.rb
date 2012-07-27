# -*- encoding : utf-8 -*-
set :output, {:error => 'log/cron_error.log', :standard => 'log/cron.log'}
every 5.minutes do
  runner "FeedEntry.update_from_feed"
end

every 1.day, :at => '4:30 am' do
  runner "FeedEntry.delete_all"
end


every 1.day, :at => '5:00 am' do
  rake "cache:clean"
end
