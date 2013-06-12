require 'spec_helper'

describe Bar do

  context 'with bottles' do
    before do
      @spirit = create(:child_spirit)
      @same_parent = create(:child_spirit, name: 'Beefeater Gin', parent: @spirit.parent)
      @bar = create(:bar)
      @bar.spirits << [@spirit, @same_parent]
      @bar.save
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

    describe '#brand_spririts' do
      it 'returns only the spirits that are brands' do
        expect(@bar.brand_spirits).to include(@spirit)
        expect(@bar.brand_spirits).not_to include(@spirit.parent)
      end
    end
    
    describe '#brand_bottles' do
      it 'returns only the bottles whose spirits are brands' do
        expect((@bar.brand_bottles & @spirit.bottles).length).to be(1)
        expect((@bar.brand_bottles & @spirit.parent.bottles).length).to be(0)
      end
    end
  end

  context 'with recipes' do
    before do
      @spirits_in_bar = create_list(:spirit, 3)
      @spirit_outside_bar = create(:spirit, name: 'Exotic Liquor')

      @ingredients_in_bar = @spirits_in_bar.map { |s| create(:ingredient, spirit: s) }
      @another_ingredients_in_bar = @spirits_in_bar.map { |s| create(:ingredient, spirit: s) }
      @ingredients_outside_bar = (@spirits_in_bar + [@spirit_outside_bar]).map { |s| create(:ingredient, spirit: s) }

      @recipe_without_ingredients = create(:recipe, ingredients: [])
      @recipe_in_bar = create(:recipe, ingredients: @ingredients_in_bar)
      @another_recipe_in_bar = create(:recipe, ingredients: @another_ingredients_in_bar, cocktail: @recipe_in_bar.cocktail)
      @recipe_outside_bar = create(:recipe, ingredients: @ingredients_outside_bar)

      @bar = create(:bar)
      @bar.spirits << @spirits_in_bar
      @bar.save
    end

    it 'can make a recipe if it has all the ingredients in the recipe' do
      puts @recipe_in_bar.ingredients.any?
      expect(@bar.can_make?(@recipe_in_bar)).to be_true
    end

    it 'cannot make a recipe if the recipe has ingredients it does not have' do
      expect(@bar.can_make?(@recipe_outside_bar)).to be_false
    end

    it 'cannot make a recipe with no ingredients' do
      expect(@bar.can_make?(@recipe_without_ingredients)).to be_false
    end

    it 'has all the recipes it can make' do
      expect(@bar.recipes).to include(@recipe_in_bar)
    end
    
    it 'has all the cocktail_ids of the recipes it can make, without duplicates' do
      expect(@bar.cocktails.length).to be(1)
    end

    it 'does not have recipes it cannot make' do
      expect(@bar.recipes).not_to include(@recipe_outside_bar)
    end
    
    context 'next bottle' do
      before :each do
        # @another_recipe_outside_bar has the same spirit outside bar as @recipe_outside_bar
        @another_ingredients_outside_bar = (@spirits_in_bar + [@spirit_outside_bar]).map {|s| create(:ingredient, spirit: s)}
        @another_spirit_outside_bar = create(:spirit, name: 'Eaux de Vie')
        @another_recipe_outside_bar = create(:recipe, ingredients: @another_ingredients_outside_bar)
        @third_ingredients_outside_bar = (@spirits_in_bar + [@another_spirit_outside_bar]).map do |s|
          i = create(:ingredient, spirit: s)
          i.save
          i
        end
        # @third_recipe_outside_bar has a different spirit outside bar
        @third_recipe_outside_bar = create(:recipe, ingredients: @third_ingredients_outside_bar)
      end
      
      describe '#next_bottle' do
        it 'returns an array of the spirits that will produce the most new recipes' do
          expect(@bar.next_bottles).to eq([@spirit_outside_bar, @another_spirit_outside_bar])
        end
      end
      describe '#ranked_spirits' do
        it 'returns a hash of all spirits with the number of new drinks that can be made if added to the bar'
      end
    end
  end
end
