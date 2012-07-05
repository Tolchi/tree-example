class CategoriesController < ApplicationController
  include TheSortableTreeController::Rebuild
  load_and_authorize_resource
  before_filter :set_ariane
  caches_page :index, :show
  cache_sweeper :category_sweeper

  # GET /categories
  # GET /categories.json
  def index
    @categories.sort! { |a, b| a.name <=> b.name }

    if params[:name]
      if c = Category.find_by_name(params[:name])
        redirect_to c and return
      else
        flash.now[:error] = "Category not found."
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    if params[:id]
      @category = Category.find_by_id(params[:id])
    elsif params[:name]
      @category = Category.find_by_name(params[:name])
    end
    if @category
      companies = Company.where('category_id = ?', @category.id).order("name ASC")
      @coms = companies.paginate(:page => params[:page], :per_page => 15)
      unless companies.blank?
        @json = companies.to_gmaps4rails do |company, marker|
          marker.json({:id => company.id})
        end
      end
      @children = @category.children and @children.sort! { |a,b| a.name <=> b.name } unless @category.leaf?
    else
      flash.now[:error] = "Category not found."
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
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
        expire_page categories_path
        expire_page category_path(@category)
        expire_page "/"
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
    ariane.add 'Categories', categories_path
  end
end
