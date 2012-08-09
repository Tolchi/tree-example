# -*- encoding : utf-8 -*-
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
#  piso          :string(255)
#  depto         :string(255)
#  ciudad        :string(255)
#  provincia     :string(255)
#  slug          :string(255)
#

# -*- encoding : utf-8 -*-
class Company < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_gmappable
  attr_accessible :category_id, :direccion, :name, :tel, :cel, :otro_contacto, :misc, :homepage, :tag_list, :piso, :depto, :ciudad, :provincia
  belongs_to :category, touch: true, counter_cache: true
  resourcify
  validates_presence_of :name, :category_id
  validates_uniqueness_of :name
  extend FriendlyId
  #friendly_id :name, use: [:globalize, :slugged, :history]
  friendly_id :name
  default_scope :order => 'name ASC'

  def direccion_completa
    unless self.direccion.blank?
      d = String.new << self.direccion
      unless self.piso.blank?
        d << " " << self.piso << "층" 
      end
      unless self.depto.blank?
        d << " " << self.depto << "호"
      end
      unless self.ciudad.eql? "Capital Federal"
        d << ", " << self.ciudad << ", " << self.provincia
      end
      d
    end
  end

  def gmaps4rails_address
    "#{self.direccion}, #{self.ciudad}, #{self.provincia}, Argentina"
  end

  def gmaps4rails_title
    "#{self.name}, #{self.direccion_completa}"
  end

  def gmaps4rails_infowindow
    info = String.new << "#{self.name}"  << ", #{self.direccion_completa}"
    unless self.tel.blank?
      info << ", #{self.tel}"
    end
    unless self.cel.blank?
      info << ", #{self.cel}"
    end
    unless self.otro_contacto.blank?
      info << ", #{self.otro_contacto}"
    end
    unless self.homepage.blank?
      info << ", #{self.homepage}"
    end
    info
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def as_json(option={})
    super(:only => [:id, :name, :direccion, :piso, :depto, :ciudad, :provincia, :tel, :cel, :otro_contacto, :homepage, :category_id])
  end
end
