class HomeController < ApplicationController
  def index
    expires_in 5.minutes, public: true
    @topcat_subcat = Hash.new
    @top_categories = Category.roots
    @top_max = @top_categories.maximum(:updated_at)
    @top_categories.sort! { |a, b| a.name <=> b.name}
    @top_categories.each do |tc|
      a = Array.new
      tc.children.each do |ch|
        a.push ch.name
      end
      @topcat_subcat[tc.name] = a.join(',')
    end
    cats = @categories
    gon.availableCategories = Array.new
    cats.each do |c|
      gon.availableCategories.push c.name
    end
    @entries_yh = FeedEntry.yh.first(5)
    @entries_tl = FeedEntry.tl.first(4)
  end
end
