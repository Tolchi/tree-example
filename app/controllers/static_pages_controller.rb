# -*- encoding : utf-8 -*-
# Static pages.
class StaticPagesController < ApplicationController
  before_filter :set_ariane

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

  protected

  def set_ariane
    ariane.add '홈', root_path
  end
end
