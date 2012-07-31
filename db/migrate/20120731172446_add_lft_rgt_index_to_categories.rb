# -*- encoding : utf-8 -*-
class AddLftRgtIndexToCategories < ActiveRecord::Migration
  def change
    add_index :categories, [:lft, :rgt]
  end
end
