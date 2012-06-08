# == Schema Information
#
# Table name: companies
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  direccion     :string(255)
#  tel           :string(255)
#  category_id   :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  cel           :string(255)
#  otro_contacto :string(255)
#  misc          :string(255)
#  homepage      :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    direccion "MyString"
    tel "MyString"
    category_id 1
  end
end
