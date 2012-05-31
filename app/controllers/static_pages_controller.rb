class StaticPagesController < ApplicationController
  def home
    @top_categories = Category.roots
  end

  def categories
    @categories = Category.all
    if params[:id]
      @category = Category.find(params[:id])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def companies
  end
end
