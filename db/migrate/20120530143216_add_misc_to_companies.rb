class AddMiscToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :misc, :string
  end
end
