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
    expect(recipe.to_json).to match(ingredient.to_json)
  end
end
