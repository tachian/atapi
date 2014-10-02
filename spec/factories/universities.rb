# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :university do
    name "MyString"
    fullname "MyString"
    description "MyText"
    status 1
  end
end
