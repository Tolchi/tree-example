# -*- encoding : utf-8 -*-
class AddParentIdIndexToCategory < ActiveRecord::Migration
  def change
    add_index :categories, :parent_id
    add_index :categories, :lft
    add_index :categories, :rgt
  end
end
