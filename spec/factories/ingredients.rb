# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    recipe_id 1
    spirit_id 1
    amount "MyString"
  end
end
