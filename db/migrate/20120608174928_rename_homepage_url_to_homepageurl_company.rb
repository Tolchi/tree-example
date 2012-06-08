class RenameHomepageUrlToHomepageurlCompany < ActiveRecord::Migration
  def up
    rename_column :companies, :homepageURL, :homepage
  end

  def down
    rename_column :companies, :homepage, :homepageURL
  end
end
