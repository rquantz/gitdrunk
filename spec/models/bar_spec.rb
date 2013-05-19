require 'spec_helper'

describe Bar do
  context 'with bottles' do
    before do
      @bar = FactoryGirl.create(:bar)
      @spirit = FactoryGirl.create(:child_spirit)
      @bar.spirits << @spirit

      @same_parent = FactoryGirl.create(:child_spirit, name: 'Beefeater Gin')
      @same_parent.parent = @spirit.parent
      @same_parent.save
      @bar.spirits << @same_parent

      @bar.save
    end
    it 'has the ancestors of all its bottles' do
      expect(@bar.spirits.include?(@spirit.parent)).to be_true
    end
    it 'does not duplicate ancestors' do
      expect(@bar).to have(3).spirits
    end
    it 'removes ancestors when a bottle is removed' do
      different_parent = FactoryGirl.create(:child_spirit, name: 'Rittenhouse Rye')
      @bar.spirits << different_parent
      @bar.save
      expect(@bar).to have(5).spirits
      @bar.spirits.delete different_parent
      expect(@bar).to have(3).spirits
    end
    it 'does not remove ancestors of bottles that are still in the bar' do
      @bar.spirits.delete @same_parent
      expect(@bar).to have(2).spirits
    end
  end
end
