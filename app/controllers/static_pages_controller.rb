class StaticPagesController < ApplicationController
  before_filter :query

  def home
    @top_categories = Category.roots
    @top_categories.sort! { |a, b| a.name <=> b.name}
    cats = Category.all
    gon.availableCategories = Array.new
    cats.each do |c|
      gon.availableCategories.push c.name
    end
  end

  def categories
    @categories = Category.all
    @categories.sort! { |a, b| a.name <=> b.name }
    if params[:id]
      @category = Category.find(params[:id])
    elsif params[:name]
      @category = Category.find_by_name(params[:name])
    end
    if @category
      @coms = Company.where('category_id = ?', @category.id).paginate(:page => params[:page], :per_page => 16)
    end
    ariane.add @category.name, cats_path(:id => @category.id)
  end

  def help
    ariane.add 'Help', help_path
  end

  def about
    ariane.add 'About', about_path
  end

  def contact
    ariane.add 'Contact', contact_path
  end

  def companies
    ariane.add 'Companies', coms_path
    @q = Company.search(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @companies = @q.result.paginate(:page => params[:page], :per_page => 20)
  end

  def company
    @company = Company.find(params[:id])
    ariane.add @company.name, com_path(:id => @company.id)
  end

  def query
    @q = Company.search(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @companies = @q.result.paginate(:page => params[:page], :per_page => 20)
  end

end
