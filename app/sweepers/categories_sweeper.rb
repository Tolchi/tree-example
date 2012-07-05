class CategorySweeper < ActionController::Caching::Sweeper
  observe Category

  def sweep(category)
    expire_page categories_path
    expire_page category_path(category)
    FileUtils.rm_rf "#{page_cache_directory}/categories/page"
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep
end
