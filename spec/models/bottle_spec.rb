require 'spec_helper'

describe Bottle do
  it 'is valid with valid attributes' do
    bottle = build(:bottle)
    expect(bottle).to be_valid
  end
  it 'is not valid without a spirit' do
    bottle = build(:bottle, spirit: nil)
    expect(bottle).not_to be_valid
  end
  it 'is not valid without a bar' do
    bottle = build(:bottle, bar: nil)
    expect(bottle).not_to be_valid
  end
  describe 'spirit_name' do
    it 'returns the name of the bottles spirit' do
      bottle = create(:bottle)
      expect(bottle.spirit_name).to eq(bottle.spirit.name)
    end
  end
  describe 'spirit_root' do
    it 'returns the name of the bottles root category' do
      spirit = create(:child_spirit)
      bottle = create(:bottle, spirit: spirit)
      expect(bottle.spirit_root).to eq(spirit.root.name)
    end
    it 'returns nil when the spirit is root' do
      spirit = create(:spirit, ancestry: nil)
      bottle = create(:bottle, spirit: spirit)
      expect(bottle.spirit_root).to be_nil
    end
  end
  describe 'to_json' do
    it 'includes the spirit_name' do
      bottle = create(:bottle)
      expect(bottle.to_json).to include(bottle.spirit_name)
    end
    it 'includes the name of the root spirit' do
      spirit = create(:child_spirit, name: 'Child spirit')
      bottle = create(:bottle, spirit: spirit)
      expect(bottle.to_json).to include(spirit.parent.name)
    end
  end
end
