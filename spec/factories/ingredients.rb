# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    recipe
    spirit
    amount "MyString"
  end
end
