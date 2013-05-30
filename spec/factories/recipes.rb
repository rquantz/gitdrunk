# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    cocktail { create(:cocktail) }
    tasting_notes "Delicious"
    instructions "Shake and stir"
    
    factory :recipe_with_ingredients do
      after(:build) do |recipe|
        ['Gin', 'Vermouth'].each do |name|
          spirit = FactoryGirl.create(:spirit, name: name)
          FactoryGirl.create(:ingredient, amount: '1 oz', recipe: recipe, spirit: spirit)
        end
      end
    end
  end
end
