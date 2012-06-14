class StaticPagesController < ApplicationController
  before_filter :query

  def home
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
      @category = Category.find_by_id(params[:id])
    elsif params[:name]
      @category = Category.find_by_name(params[:name])
    end
    if @category
      @coms = Company.where('category_id = ?', @category.id).order("name ASC").paginate(:page => params[:page], :per_page => 24)
      @children = @category.children and @children.sort! { |a,b| a.name <=> b.name } unless @category.leaf?
    elsif params[:name] or params[:id]
      flash.now[:error] = "Category not found."
    end
    ariane.add @category.name, cats_path(:id => @category.id)
  end

  def tag
    if params[:tag]
      @companies = Company.tagged_with(params[:tag])
    else
      flash.now[:error] = "tag not present"
    end
  end

  def help
    ariane.add 'Help', help_path
  end

  def about
    ariane.add 'About', about_path
  end

  def forum

  end

  def market

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
    if @companies.count == 0 
      flash.now[:error] = "Companies not found"
    end
  end

end
