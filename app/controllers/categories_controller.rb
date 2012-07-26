# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild
  load_and_authorize_resource
  before_filter :set_ariane, :category_sort
  #caches_page :index
  #cache_sweeper :category_sweeper

  # GET /categories
  # GET /categories.json
  def index
    #expires_in 24.hours
    #fresh_when last_modified: @max, public: true
    @roots = Category.roots

    if params[:id]
      if c = Category.find(params[:id])
        redirect_to c 
        return
      else
        flash.now[:error] = "Category not found."
      end
    end

    respond_to do |format|
      format.html
      format.json {render json:@categories}
    end

  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
    if request.path != category_path(@category)
      redirect_to @category, status: :moved_permanently
    end
    if @category
      companies = @category.companies.order('name ASC')
      @coms = companies.paginate(:page => params[:page], :per_page => 15)
      unless companies.blank?
        @json = companies.to_gmaps4rails do |company, marker|
          marker.infowindow render_to_string(:partial => "companies/infowindow", :locals => { :object => company})
          marker.title "#{company.name}"
          marker.json({:id => company.id})
        end
        @coms_max = companies.maximum(:updated_at)
      end
      @children = @category.children and @children.sort! { |a,b| a.name <=> b.name } unless @category.leaf?
      if @category.child?
        @category.ancestors.each do |ac|
          ariane.add ac.name, category_path(ac)
        end
      end
      ariane.add @category.name, @category
    else
      flash.now[:error] = "Category not found."
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  def manage
    @categories = Category.nested_set.all
  end
  
  protected
  def set_ariane
    super
    ariane.add '카테고리', categories_path
  end

  def category_sort
    @categories.sort! { |a, b| a.name <=> b.name }
  end
end
