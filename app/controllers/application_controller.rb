class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_categories
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protected
  
  def fetch_categories
    @categories = Category.all
  end
end
