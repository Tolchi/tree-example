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
#

class Company < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_gmappable
  attr_accessible :category_id, :direccion, :name, :tel, :cel, :otro_contacto, :misc, :homepage, :tag_list, :piso, :depto, :ciudad, :provincia
  belongs_to :category, touch: true
  resourcify
  validates_presence_of :name, :direccion, :category_id
  validates_uniqueness_of :name
  extend FriendlyId
  #friendly_id :name, use: [:globalize, :slugged, :history]
  friendly_id :name

  def company_logger
    @company_logger ||= Logger.new("#{Rails.root}/log/com.log")
  end
  def direccion_completa
    unless self.direccion.blank?
      d = self.direccion
      d = d + " " + self.piso + "층 "  unless self.piso.blank?
      d = d + self.depto + "호" unless self.depto.blank?
      d = d + ", " + self.ciudad + ", " + self.provincia unless self.ciudad.eql? "Capital Federal"
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
    info= "#{self.name}, #{self.direccion_completa}"
    info = info + ", #{self.tel}" unless self.tel.blank?
    info = info + ", #{self.cel}" unless self.cel.blank?
    info = info + ", #{self.otro_contacto}" unless self.otro_contacto.blank?
    info = info + ", #{self.homepage}" unless self.homepage.blank?
    company_logger.info("infowindow = #{info}")
    info
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
