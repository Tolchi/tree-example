class AddIndexesToCategories < ActiveRecord::Migration
  def change
    add_index :categories, [:lft, :id]
    add_index :categories, [:id, :lft, :rgt]
    add_index :categories, [:parent_id, :lft, :rgt]
  end
end
