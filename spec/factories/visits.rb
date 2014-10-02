# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    user nil
    course nil
    lecture nil
    part nil
    time 1
    status 1
  end
end
