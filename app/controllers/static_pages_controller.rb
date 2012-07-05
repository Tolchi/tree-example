class StaticPagesController < ApplicationController
  before_filter :set_ariane

  def categories
    @categories.sort! { |a, b| a.name <=> b.name }
    if params[:id]
      @category = Category.find_by_id(params[:id])
    elsif params[:name]
      @category = Category.find_by_name(params[:name])
    end
    ariane.add 'Categories', cats_path
    if @category
      companies = Company.where('category_id = ?', @category.id).order("name ASC")
      @coms = companies.paginate(:page => params[:page], :per_page => 15)
      unless companies.blank?
        @json = companies.to_gmaps4rails do |company, marker|
          marker.json({:id => company.id})
        end
      end
      @children = @category.children and @children.sort! { |a,b| a.name <=> b.name } unless @category.leaf?
      if @category.child?
        @category.ancestors.each do |ac|
          ariane.add ac.name, cats_path(:id => ac.id)
        end
      end
      ariane.add @category.name, cats_path(:id => @category.id)
    elsif params[:name] or params[:id]
      flash.now[:error] = "Category not found."
    end
  end

  def tag
    if params[:tag]
      @companies = Company.tagged_with(params[:tag])
      @companies.sort! { |a,b| a.name <=> b.name }
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
    @json = @company.to_gmaps4rails
    @tags = @company.tag_list
    ariane.add 'Companies', coms_path
    ariane.add @company.name, com_path(:id => @company.id)
  end

  protected

  def set_ariane
    super
  end
end
