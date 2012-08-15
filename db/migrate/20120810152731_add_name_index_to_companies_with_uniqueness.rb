# -*- encoding : utf-8 -*-
class AddNameIndexToCompaniesWithUniqueness < ActiveRecord::Migration
  def change
    add_index :companies, :name, unique: true
  end
end
