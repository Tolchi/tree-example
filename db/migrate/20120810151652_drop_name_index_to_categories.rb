# -*- encoding : utf-8 -*-
class DropNameIndexToCategories < ActiveRecord::Migration
  def change
    remove_index :categories, :name
  end
end
