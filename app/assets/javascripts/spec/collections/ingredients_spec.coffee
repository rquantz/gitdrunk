describe "Ingredients", ->
  ingredients = null

  beforeEach ->
    ingredients = build_ingredients()
    
  describe 'set_recipe_order', ->
    beforeEach ->
      j = 5
      recipe_order = {}
      ingredients.each (i) -> recipe_order[i.cid] = --j
      ingredients.set_recipe_order(recipe_order)
      
    it 'sets the recipe_order attribute for each model', ->
      not_empty = ingredients.filter (i) -> i.get('recipe_order')?
      expect(not_empty.length).toEqual(ingredients.length)
      
    it 'orders the models by recipe_order', ->
      expect(ingredients.last().get('recipe_order')).toBe(4)
      expect(ingredients.first().get('recipe_order')).toBe(0)
      
