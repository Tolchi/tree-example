# -*- encoding : utf-8 -*-
module FetchCategories
  def fetch_categories
    @categories = Category.scoped.order("name ASC")
    @max = @categories.maximum(:updated_at)
  end
end
