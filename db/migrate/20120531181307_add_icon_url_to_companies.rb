class AddIconUrlToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :icon, :string
    add_column :companies, :url, :string
  end
end
