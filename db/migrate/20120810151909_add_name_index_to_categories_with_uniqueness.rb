# -*- encoding : utf-8 -*-
class AddNameIndexToCategoriesWithUniqueness < ActiveRecord::Migration
  def change
    add_index :categories, :name, unique: true
  end
end
