# -*- encoding : utf-8 -*-
class AddIndexToCategoriesUpdatedAt < ActiveRecord::Migration
  def change
    add_index :categories, :updated_at
  end
end
