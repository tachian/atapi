# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :part do
    lecture nil
    name "MyString"
    teacher "MyString"
    url "MyString"
    duration 1
    order 1
  end
end
