# -*- encoding : utf-8 -*-
class AddIconToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :icon, :string
  end
end
