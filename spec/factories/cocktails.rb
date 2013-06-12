# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cocktail do
    name { Faker::Name.first_name + Faker::Name.last_name }
    description "MyText"
  end
end
