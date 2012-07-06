class HomeController < ApplicationController
  caches_page :index
  before_filter(only: [:index]) {@page_caching = true}
  def index
    expire_fragment "news_feed"
    @topcat_subcat = Hash.new
    @top_categories = Category.roots
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
  end
end
