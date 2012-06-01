class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_categories
  before_filter :set_ariane
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protected
  
  def fetch_categories
    @categories = Category.all
  end
  
  def set_ariane
    ariane.add 'Home', root_path
  end
end
