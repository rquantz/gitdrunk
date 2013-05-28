# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    recipe
    spirit 
    amount "1 oz"
    
    factory :invalid_ingredient do
      recipe nil
      spirit 'bad id'
      amount nil
    end
  end
end
