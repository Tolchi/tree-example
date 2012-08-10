class AddIndexToCategoriesUpdatedAt < ActiveRecord::Migration
  def change
    add_index :categories, :updated_at
  end
end
