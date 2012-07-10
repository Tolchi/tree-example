class CompanySweeper < ActionController::Caching::Sweeper
  observe Company

  def sweep(company)
    expire_page companies_path
    expire_page company_path(company)
    FileUtils.rm_rf "#{page_cache_directory}/companies/page"
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep
end
