# -*- encoding : utf-8 -*-
# Home controller.(root_path)
class HomeController < ApplicationController
  include FetchCategories
  before_filter :fetch_categories
  def index
    @topcat_subcat = Hash.new
    @top_categories = @categories.roots
    @keyword = String.new
    @top_categories.each do |tc|
      @keyword << tc.name << " "
      a = Array.new
      unless tc.leaf?
        tc.children.each do |ch|
          a.push ch
        end
      end
      @topcat_subcat[tc.name] = a
    end
  end
end
