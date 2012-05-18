class Company < ActiveRecord::Base
  attr_accessible :category_id, :direccion, :name, :tel
  belongs_to :category
end
