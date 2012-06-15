class AddGmapsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :gmaps, :boolean
  end
end
