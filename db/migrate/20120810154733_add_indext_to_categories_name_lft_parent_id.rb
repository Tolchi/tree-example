# -*- encoding : utf-8 -*-
class AddIndextToCategoriesNameLftParentId < ActiveRecord::Migration
  def change
    add_index :categories, [:parent_id, :name, :lft]
  end
end
