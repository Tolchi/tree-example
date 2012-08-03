# -*- encoding : utf-8 -*-
class CompaniesDatatable
  delegate :params, :h, :to_i, :link_to, to: :@view

  def initialize(view)
    @view = view
  end
  
  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Company.count,
      iTotalDisplayRecords: companies.total_entries,
      aaData: data
    }
  end

  private

    def data
      companies.map do |company|
        [
          link_to(company.name, company),
          company.direccion_completa,
          company.tel,
          company.cel,
          link_to(company.category.name, company.category)
        ]
      end
    end

    def companies
      @companies ||= fetch_companies
    end

    def fetch_companies
      companies = Company.unscoped
      companies = companies.order("#{sort_column} #{sort_direction}")
      companies = companies.page(page).per_page(per_page)
      if params[:sSearch].present?
        companies = companies.joins(:category).where(
          "companies.name like :search or categories.name like :search or direccion like :search or tel like :search or cel like :search", 
          search: "%#{params[:sSearch]}%")
      end
      companies
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end
    
    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[name direccion tel cel category_id]
      columns[params[:iSortCol_0].to_i]
    end
    
    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end
end
