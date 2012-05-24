class StaticPagesController < ApplicationController
  def home
    @top_categories = Category.roots
  end

  def help
  end

  def about
  end

  def contact
  end
end
