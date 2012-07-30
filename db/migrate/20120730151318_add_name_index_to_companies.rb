class AddNameIndexToCompanies < ActiveRecord::Migration
  def change
    add_index :companies, :name
    add_index :companies, :tel
    add_index :companies, :cel
    add_index :companies, :homepage
    add_index :companies, :category_id
  end
end
