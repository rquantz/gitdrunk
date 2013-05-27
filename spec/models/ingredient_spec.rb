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
end
