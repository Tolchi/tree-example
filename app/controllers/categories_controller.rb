# -*- encoding : utf-8 -*-
class CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild
  include FetchCategories
  load_and_authorize_resource
  before_filter :set_ariane, :fetch_categories
  #caches_page :index
  #cache_sweeper :category_sweeper

  # GET /categories
  # GET /categories.json
  def index
    #expires_in 24.hours
    #fresh_when last_modified: @max, public: true
    @roots = Category.includes(:children).roots
    @keyword = String.new

    @roots.each do |r|
      @keyword << r.name << " "
    end

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
    @category = Category.includes(:children).includes(:companies).find(params[:id])
    if request.path != category_path(@category)
      redirect_to @category, status: :moved_permanently
    end
    if @category
      @keyword = String.new 
      @keyword << @category.name << " "
      @coms = @category.companies.paginate(:page => params[:page], :per_page => 15)
      unless @category.leaf?
        @children = @category.children
        @children.each do |child|
          @keyword << child.name << " "
        end
      end
      if @category.child?
        @category.ancestors.each do |ac|
          ariane.add ac.name, category_path(ac)
        end
      end
      unless @category.companies.blank?
        ###@json = @category.companies.to_gmaps4rails do |company, marker|
        ###  marker.infowindow render_to_string(:partial => "companies/infowindow", :locals => { :object => company})
        ###  marker.title "#{company.name}"
        ###  marker.json({:id => company.id})
        ###  @keyword << company.name << " "
        ###end
        @json = @category.companies.to_gmaps4rails
        @coms_max = @category.companies.maximum(:updated_at)
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
end
