describe "Recipe", ->
  describe "when instantiated", ->
    recipe = null

    beforeEach ->
      recipe = build_recipe();

    it "has a url based on its id", ->
      expect(recipe.url()).toEqual("/recipes/1");
    
    it "instantiates a collection of ingredients", ->
      expect(recipe.ingredients.length).toBe(1)
      
    describe "tracks changes to the ingredients collection", ->
      beforeEach ->
        recipe.ingredients.add(
          new App.Models.Ingredient
            spirit_name: 'Cointreau'
            spirit_id: 234
            recipe_id: recipe.id
            amount: "1 oz"
        )

      it 'adds an ingredient when an ingredient is added to the collection', ->
        expect(recipe.get('ingredients').length).toBe(2)
        
      it 'removes an ingredient when an ingredient is removed from the collection', ->
        recipe.ingredients.pop()
        expect(recipe.get('ingredients').length).toBe(1)
        recipe.ingredients.pop()
        expect(recipe.get('ingredients').length).toBe(0)
        
    
  describe "without ingredients", ->
    it "has an empty ingredients attribute", ->
      recipe = new App.Models.Recipe(
        id: 1,
        cocktail_id: 2,
        tasting_notes: "Delicious",
      )
      expect(recipe.ingredients.length).toBe(0);

