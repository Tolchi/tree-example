# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  icon       :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :icon
  acts_as_nested_set
  include TheSortableTree::Scopes
  has_many :companies
  resourcify
  validates :name, presence: true, uniqueness: true
end
