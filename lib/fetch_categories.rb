# -*- encoding : utf-8 -*-
module FetchCategories
  def fetch_categories
    @categories = Category.name_ordered.includes(:children)
  end
end
