class FeedEntry < ActiveRecord::Base
  attr_accessible :guid, :hashe, :name, :published_at, :source, :summary, :url
  scope :yh , where("source = ?", 'yh').order("published_at DESC")
  scope :tl , where("source = ?", 'tl').order("published_at DESC")

  def self.update_from_feed(feed_url, source)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, source)
  end

  def self.update_from_feed_continously(feed_url, source, delay_interval = 10.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, source)
    loop do 
      sleep delay_interval.to_i
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries, source) if feed.updated?
    end
  end

  private

  def self.add_entries(entries, source)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title,
          :summary      => ActionController::Base.helpers.strip_tags(entry.summary),
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
          :hashe        => entry.hash,
          :source       => source
        )
      end
    end
  end
end
