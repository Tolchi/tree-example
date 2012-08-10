class AddNameIndexToCompaniesWithUniqueness < ActiveRecord::Migration
  def change
    add_index :companies, :name, unique: true
  end
end
