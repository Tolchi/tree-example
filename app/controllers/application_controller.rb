# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  helper_method :is_admin?

  protected

  def is_admin?
    adm = user_signed_in? and current_user.has_role? :admin
    adm
  end
end
