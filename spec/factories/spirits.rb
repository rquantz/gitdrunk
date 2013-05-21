# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :spirit do
    name "Gin"
    is_brand false

    factory :child_spirit do
      name 'Plymouth Gin'
      is_brand true
      parent { create(:spirit) }
    end
    
    factory :invalid_spirit do
      name nil
    end
  end
end
