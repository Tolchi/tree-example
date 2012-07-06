# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_entry do
    name "MyString"
    summary "MyText"
    url "MyString"
    published_at "2012-07-06 15:06:38"
    guid "MyString"
    hash "MyString"
    sourse "MyString"
  end
end
