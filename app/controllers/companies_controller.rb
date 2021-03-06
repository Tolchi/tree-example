# -*- encoding : utf-8 -*-
# Companies controller
# not much to say.
class CompaniesController < ApplicationController
  before_filter :set_ariane
  load_and_authorize_resource

  # GET /companies
  # GET /companies.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: CompaniesDatatable.new(view_context) }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.includes(:category).find(params[:id])
    @json = @company.to_gmaps4rails
    @tags = @company.tag_list
    ariane.add @company.name, @company
    @keyword = String.new
    @keyword << @company.name << " " << @company.category.name << " "
    unless @tags.to_s.nil?
      if @tags.size > 1
        @keyword << @tags.to_s.gsub!(/,/, "")
      else
        @keyword << @tags.to_s
      end
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html {
          redirect_to @company, notice: 'Company was successfully created.'
        }
        format.json {
          render json: @company, status: :created, location: @company
        }
      else
        format.html { render action: "new" }
        format.json {
          render json: @company.errors, status: :unprocessable_entity
        }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html {
          redirect_to @company, notice: 'Company was successfully updated.'
        }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json {
          render json: @company.errors, status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
  protected
  def set_ariane
    ariane.add '홈', root_path
    ariane.add '업소록', companies_path
  end
end
