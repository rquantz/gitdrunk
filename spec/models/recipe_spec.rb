require 'spec_helper'

describe Recipe do
  it 'is valid with valid attributes' do
    expect(build(:recipe)).to be_valid
  end
  it 'is not valid without a cocktail' do
    expect(build(:recipe, cocktail: nil)).not_to be_valid
  end
  it "includes its ingredients when converted to json" do
    ingredient = create(:ingredient)
    recipe = create(:recipe, ingredients: [ingredient])
    expect(recipe.to_json).to include(recipe.ingredients.to_json)
  end
  it 'orders ingredients by recipe_order' do
    ingredients = create_list(:ingredient, 4)
    recipe = create(:recipe, ingredients: ingredients)  
    expect(recipe.ingredients).to eq(recipe.ingredients.order(:recipe_order))
  end
end
