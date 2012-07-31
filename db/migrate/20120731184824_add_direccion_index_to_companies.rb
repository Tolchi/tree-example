# -*- encoding : utf-8 -*-
class AddDireccionIndexToCompanies < ActiveRecord::Migration
  def change
    add_index :companies, :direccion
  end
end
