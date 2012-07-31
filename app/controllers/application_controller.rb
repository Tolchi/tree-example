# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_ariane, :query
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  helper_method :is_admin?

  protected
  
  def query
    @q = Company.includes(:category).search(params[:q])
    #@q.sorts = 'name asc' if @q.sorts.empty?
  end

  def set_ariane
    ariane.add '홈', root_path
  end
  
  def is_admin?
    adm = user_signed_in? and current_user.has_role? :admin
    adm
  end

end
