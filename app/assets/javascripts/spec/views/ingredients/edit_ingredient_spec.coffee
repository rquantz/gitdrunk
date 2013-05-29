describe 'EditIngredient', ->
  
  describe 'when instantiated', ->
    edit_ingredient_view = null
    ingredient = null
    
    beforeEach ->
      ingredient = new App.Models.Ingredient({
        recipe_id: 1,
        spirit_id: 2,
        amount: '1 oz',
        spirit_name: 'Gin'
      })
      edit_ingredient_view = new App.Views.EditIngredient({model: ingredient})

    it 'has an element', ->
      expect(edit_ingredient_view.$el).toBe('li.ingredient.edit_ingredient')
    
    it 'contains the spirit name', ->
      expect(edit_ingredient_view.$el.html()).toMatch(ingredient.get('spirit_name'))
