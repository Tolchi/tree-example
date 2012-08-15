# -*- encoding : utf-8 -*-
class AddCompaniesCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :companies_count, :integer, default: 0, null: false
  end
end
