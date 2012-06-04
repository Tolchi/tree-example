class StaticPagesController < ApplicationController
  before_filter :query

  def home
    @top_categories = Category.roots
  end

  def categories
    @categories = Category.all
    if params[:id]
      @category = Category.find(params[:id])
      @coms = Company.where('category_id = ?', params[:id]).paginate(:page => params[:page], :per_page => 15)
      ariane.add @category.name, cats_path(:id => @category.id)
    end

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
