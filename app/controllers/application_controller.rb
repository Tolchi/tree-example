# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_categories, :set_ariane, :query
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protected
  
  def fetch_categories
    @categories = Category.scoped
    @max = @categories.maximum(:updated_at)
  end
  
  def query
    @q = Company.search(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @companies = @q.result.paginate(:page => params[:page], :per_page => 20)
    if @companies.count == 0 
      flash.now[:error] = "Companies not found"
    end
  end

  def set_ariane
    ariane.add '홈', root_path
  end
end
