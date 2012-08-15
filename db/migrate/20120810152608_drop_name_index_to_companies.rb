# -*- encoding : utf-8 -*-
class DropNameIndexToCompanies < ActiveRecord::Migration
  def change
    remove_index :companies, :name
  end
end
