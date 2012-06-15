# == Schema Information
#
# Table name: companies
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  direccion     :string(255)
#  tel           :string(255)
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  cel           :string(255)
#  otro_contacto :string(255)
#  misc          :string(255)
#  homepage      :string(255)
#  latitude      :float
#  longitude     :float
#  gmaps         :boolean
#

class Company < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_gmappable
  attr_accessible :category_id, :direccion, :name, :tel, :cel, :otro_contacto, :misc, :homepage, :tag_list
  belongs_to :category
  resourcify
  validates_presence_of :name, :direccion, :category_id
  validates_uniqueness_of :name

  def gmaps4rails_address
    "#{self.direccion}, Capital Federal, Argentina"
  end
end
