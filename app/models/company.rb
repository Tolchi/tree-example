# == Schema Information
#
# Table name: companies
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  direccion   :string(255)
#  tel         :string(255)
#  category_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Company < ActiveRecord::Base
  attr_accessible :category_id, :direccion, :name, :tel
  belongs_to :category
  resourcify
end
