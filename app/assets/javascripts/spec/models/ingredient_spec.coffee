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
      
    it 'is valid with valid attrbutes', ->
      expect(ingredient.isValid()).toBeTruthy()
      
    it 'is not valid without a spirit_id', ->
      ingredient.set('spirit_id', null)
      expect(ingredient.isValid()).toBeFalsy()
      
    it 'is not valid without an amount', ->
      ingredient.set('amount', null)
      expect(ingredient.isValid()).toBeFalsy()

    it 'is not valid without a spirit_name', ->
      ingredient.set('spirit_name', null)
      expect(ingredient.isValid()).toBeFalsy()
      
    it 'is not valid without a recipe_id', ->
      ingredient.set('recipe_id', null)
      expect(ingredient.isValid()).toBeFalsy()


      
    
