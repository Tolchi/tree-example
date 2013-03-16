name space :scheduler do
  desc "This task is called by the Heroku scheduler add-on"
  task :update_feed => :environment do
      puts "Updating feed..."
      FeedEntry.update_from_feed
      puts "done."
  end

  desc "This task is deleting all feed entries."
  task :delete_all_feed => :environment do
    puts "Deleting all feed entries"
    FeedEntry.delete_all
    puts "Done."
  end
end
