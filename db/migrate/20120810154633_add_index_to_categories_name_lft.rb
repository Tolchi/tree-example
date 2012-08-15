# -*- encoding : utf-8 -*-
class AddIndexToCategoriesNameLft < ActiveRecord::Migration
  def change
    add_index :categories, [:name, :lft]
  end
end
