# -*- encoding : utf-8 -*-
class AddPisoDeptoCiudadProvinciaToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :piso, :string
    add_column :companies, :depto, :string
    add_column :companies, :ciudad, :string
    add_column :companies, :provincia, :string
  end
end
