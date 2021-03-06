# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  icon       :string(255)
#  slug       :string(255)
#

# -*- encoding : utf-8 -*-
# Category model
# using nested_set to implement subcategories
class Category < ActiveRecord::Base
  scope :name_ordered, order("name ASC")
  attr_accessible :name, :parent_id, :icon
  acts_as_nested_set
  include TheSortableTree::Scopes
  has_many :companies, :order => 'name ASC', :inverse_of => :category
  resourcify
  validates :name, presence: true, uniqueness: true
  extend FriendlyId
  #friendly_id :name, use: [:globalize, :slugged, :history]
  friendly_id :name
  #default_scope :order => 'name ASC'

  def should_generate_new_friendly_id?
    new_record?
  end

  def as_json(option={})
    super(:only => [:id, :name, :parent_id])
  end
end
