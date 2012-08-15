# -*- encoding : utf-8 -*-
class DropIndexesToCategories < ActiveRecord::Migration
  def change
    remove_index :categories, [:lft, :rgt]
    remove_index :categories, :lft
    remove_index :categories, :rgt
  end
end
