# == Schema Information
#
# Table name: feed_entries
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  summary      :text
#  url          :string(255)
#  published_at :datetime
#  guid         :string(255)
#  hashe        :string(255)
#  source       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class FeedEntry < ActiveRecord::Base
  attr_accessible :guid, :hashe, :name, :published_at, :source, :summary, :url
  scope :yh , where("source = ?", 'yh').order("guid DESC")
  scope :tl , where("source = ?", 'tl').order("guid DESC")

  def self.update_from_feed
    feed = Feedzirra::Feed.fetch_and_parse("http://www.yonhapnews.co.kr/RSS/sokbo.xml")
    add_entries(feed.entries, 'yh')
    feed = Feedzirra::Feed.fetch_and_parse("http://www.telam.com.ar/xml/rss/")
    add_entries(feed.entries, 'tl')
  end

  private

  def self.add_entries(entries, source)
    modificado = false
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title,
          :summary      => entry.summary.strip,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
          :hashe        => entry.hash,
          :source       => source
        )
        modificado = true
      end
    end
    if modificado
      ActionController::Base.new.expire_fragment("news_feed")
    end
  end
end
