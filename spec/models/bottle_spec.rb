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
  describe 'to_json' do
    it 'includes the spirit_name' do
      bottle = create(:bottle)
      expect(bottle.to_json).to include(bottle.spirit_name)
    end
  end
end
