require 'spec_helper'

describe Spirit do
  describe 'validations' do
    it 'should be valid with valid attributes' do
      expect(build(:spirit)).to be_valid
    end
    it 'is not valid without a name' do
      expect(build(:spirit, name: nil)).not_to be_valid
    end
  end
  
  describe 'acts as a tree' do
    it 'should not have a parent if it is a top level category' do
      expect(build(:spirit).parent).to be_nil
    end
    it 'should have a parent if it is a child' do
      child_spirit = build(:child_spirit)
      expect(child_spirit.parent).not_to be_nil
    end
    it 'belongs to a category if that category is a spirit in its ancestry' do
      child_spirit = build(:child_spirit)
      spirit = child_spirit.parent
      expect(child_spirit.in_category? spirit).to be_true
    end
  end
end
