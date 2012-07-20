# -*- encoding : utf-8 -*-
class AddHomepageUrlToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :homepageURL, :string
  end
end
