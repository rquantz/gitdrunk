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
  
  describe 'sub_spirit' do
    before :each do
      @ingredient = create(:ingredient)
      @new_spirit = create(:spirit)
    end
    it 'switches which spirit is used in all ingredients using a particular spirit' do
      Ingredient.sub_spirit(@ingredient.spirit_id, @new_spirit.id)
      expect(@ingredient.reload.spirit).to eq(@new_spirit)
    end
    it 'does not affect other ingredients' do
      other_spirit = create(:spirit)
      other_ingredient = create(:ingredient, spirit: other_spirit)
      Ingredient.sub_spirit(@ingredient.spirit_id, @new_spirit.id)
      expect(other_ingredient.reload.spirit).to eq(other_spirit)
    end
  end
end
