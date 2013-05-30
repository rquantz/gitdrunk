describe "Ingredient", ->
  
  describe "when instantiated", ->
    ingredient = null

    beforeEach ->
      ingredient = new App.Models.Ingredient
        id: 1
        amount: "1 oz"
        spirit_name: "Gin"
        spirit_id: 2
        recipe_id: 3
    
    it "has a url based on its id", ->
      expect(ingredient.url()).toEqual("/ingredients/1")
    
