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
require 'spec_helper'

describe Company do
  pending "add some examples to (or delete) #{__FILE__}"
end
