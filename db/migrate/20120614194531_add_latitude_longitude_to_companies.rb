# -*- encoding : utf-8 -*-
class AddLatitudeLongitudeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :latitude, :float
    add_column :companies, :longitude, :float
  end
end
