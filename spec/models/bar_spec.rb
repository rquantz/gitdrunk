require 'spec_helper'

describe Bar do

  context 'with bottles' do
    before do
      @spirit = create(:child_spirit)
      @same_parent = create(:child_spirit, name: 'Beefeater Gin', parent: @spirit.parent)
      @bar = create(:bar, spirits: [@spirit, @same_parent])
    end

    it 'has the ancestors of all its bottles' do
      expect(@bar.spirits.include?(@spirit.parent)).to be_true
    end

    it 'does not duplicate ancestors' do
      expect(@bar).to have(3).spirits
    end

    it 'removes ancestors when a bottle is removed' do
      different_parent = create(:child_spirit, name: 'Rittenhouse Rye')
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

  context 'with recipes' do
    before do
      @spirits_in_bar = create_list(:spirit, 3)
      @spirit_outside_bar = create(:spirit, name: 'Exotic Liquor')

      @ingredients_in_bar = @spirits_in_bar.map { |s| create(:ingredient, spirit: s) }
      @ingredient_outside_bar = create(:ingredient, spirit: @spirit_outside_bar)

      @recipe_in_bar = create(:recipe, ingredients: @ingredients_in_bar)
      @recipe_outside_bar = create(:recipe, ingredients: (@ingredients_in_bar + [@ingredient_outside_bar]))

      @bar = create(:bar, spirits: @spirits_in_bar)
    end

    it 'can make a recipe if it has all the ingredients in the recipe' do
      expect(@bar.can_make?(@recipe_in_bar)).to be_true
    end

    it 'cannot make a recipe if the recipe has ingredients it does not have' do
      expect(@bar.can_make?(@recipe_outside_bar)).to be_false
    end

    it 'has all the recipes it can make' do
      expect(@bar.recipes).to include(@recipe_in_bar)
    end

    it 'does not have recipes it cannot make' do
      expect(@bar.recipes).not_to include(@recipe_outside_bar)
    end
  end
end
