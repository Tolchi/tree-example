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
require 'spec_helper'

describe Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
