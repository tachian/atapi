# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    university nil
    avatar "MyString"
    name "MyString"
    description "MyText"
    status 1
  end
end
