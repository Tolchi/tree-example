class CacheCompaniesCount < ActiveRecord::Migration
  def up
    execute "update categories set companies_count=(select count(*) from companies where category_id=categories.id)"
  end

  def down
  end
end
