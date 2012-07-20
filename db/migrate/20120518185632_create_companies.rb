# -*- encoding : utf-8 -*-
class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :direccion
      t.string :tel
      t.integer :category_id

      t.timestamps
    end
  end
end
