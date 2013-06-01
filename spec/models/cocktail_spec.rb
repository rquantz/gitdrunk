require 'spec_helper'

describe Cocktail do
  it 'is valid with valid attributes' do
    expect(build(:cocktail)).to be_valid
  end
  it 'is not valid without a name' do
    expect(build(:cocktail, name: nil)).not_to be_valid
  end
  it 'must have a unique name' do
    create(:cocktail, name: 'Aviation')
    expect(build(:cocktail, name: 'Aviation')).not_to be_valid
  end
end
