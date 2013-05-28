require 'spec_helper'

describe Ingredient do
  it 'is valid with valid attributes' do
    expect(build(:ingredient)).to be_valid
  end
  it 'is not valid without an amount' do
    expect(build(:ingredient, amount: nil)).not_to be_valid
  end
  it 'is not valid without a spirit' do
    expect(build(:ingredient, spirit: nil)).not_to be_valid
  end
  it 'is not valid without a recipe' do
    expect(build(:ingredient, recipe: nil)).not_to be_valid
  end

  describe 'spirit_name' do
    it "returns the name of the ingredient's spirit" do
      ingredient = create(:ingredient)
      expect(ingredient.spirit_name).to eq ingredient.spirit.name
    end
  end

  it 'includes its spirit name when converted to json' do
    spirit = create(:spirit)
    ingredient = create(:ingredient, spirit: spirit)
    expect(ingredient.to_json).to include(ingredient.spirit_name)
  end
end
