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

  describe 'root_name' do
    before :each do
      @spirit = build(:child_spirit)
    end
    it 'returns the name of the root spirit' do
      expect(@spirit.root_name).to eq(@spirit.root.name)
    end
    it 'returns nil when the spirit is a root spirit' do
      expect(build(:spirit).root_name).to be_nil
    end
  end
  
  describe 'to_json' do
    it 'contains the root_spirit' do
      expect(build(:child_spirit).to_json).to match('root_name')
    end
  end
  
  describe 'brand_only' do
    before :each do
      @spirit = create(:spirit)
      @child_spirit = create(:child_spirit)
    end
    it 'returns the spirits that are brands' do
      spirits = Spirit.brand_only
      expect(spirits).to include(@child_spirit)
      expect(spirits).not_to include(@spirit)
    end
  end
end
