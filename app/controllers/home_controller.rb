# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @topcat_subcat = Hash.new
    #@top_categories = Category.roots
    #@top_categories.sort! { |a, b| a.name <=> b.name}
    @top_categories = Category.select("id, name, parent_id, icon, lft, rgt").where("parent_id is ?", nil).order("name ASC") # equivalent above 2 lines
    @top_categories.each do |tc|
      a = Array.new
      unless tc.leaf? 
        tc.children.each do |ch|
          a.push ch.name
        end
      end
      @topcat_subcat[tc.name] = a.join(',')
    end
  end
end
