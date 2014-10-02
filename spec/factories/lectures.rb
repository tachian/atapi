# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    course nil
    name "MyString"
    subtitle "MyString"
    avatar "MyString"
    order 1
  end
end
