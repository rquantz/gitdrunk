# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    recipe { create(:recipe) }
    spirit { create(:spirit) }
    amount "1 oz"
  end
end
