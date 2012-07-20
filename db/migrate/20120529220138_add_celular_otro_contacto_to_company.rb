# -*- encoding : utf-8 -*-
class AddCelularOtroContactoToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :cel, :string
    add_column :companies, :otro_contacto, :string
  end
end
