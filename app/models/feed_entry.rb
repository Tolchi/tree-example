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
    # Need to optimize this
    feed = Feedzirra::Feed.fetch_and_parse("http://www.yonhapnews.co.kr/RSS/sokbo.xml")
    yh = add_entries(feed.entries, 'yh')
    feed = Feedzirra::Feed.fetch_and_parse("http://www.telam.com.ar/xml/rss/")
    tl = add_entries(feed.entries, 'tl')
    if yh or tl # 두개중 하나라도 업데이트가 되었으면 캐시를 지운다.
      ActionController::Base.new.expire_fragment("news_feed")
    end
  end

  private

  def self.add_entries(entries, source)
    modificado = false
    entries.each do |entry| # Here(maybe) produce app error: undefined method `each' for nil:NilClass (NoMethodError) unicorn error
      upd = false
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
        upd = true
      end
      if upd
        modificado = true
      else
        break
      end
    end
    modificado
  end
end
