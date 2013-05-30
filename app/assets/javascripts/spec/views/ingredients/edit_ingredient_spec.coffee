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
      expect(edit_ingredient_view.$el).toBe('tr.ingredient.edit_ingredient')
    
    it 'contains the spirit name', ->
      expect(edit_ingredient_view.$el.html()).toMatch(ingredient.get('spirit_name'))
      
    describe 'delete', ->
      it 'removes the ingredient from the DOM', ->
        spyOn(edit_ingredient_view, 'remove')
        edit_ingredient_view.delete()
        expect(edit_ingredient_view.remove).toHaveBeenCalled()

      it 'destroys the ingredient model', ->
        spyOn(edit_ingredient_view.model, 'destroy')
        edit_ingredient_view.delete()
        expect(edit_ingredient_view.model.destroy).toHaveBeenCalled()
        
      it 'is called when delete_ingredient_btn is clicked', ->
        spyOn(edit_ingredient_view, 'delete')
        edit_ingredient_view.$('.delete_ingredient_btn').trigger('click')
        expect(edit_ingredient_view.delete).toHaveBeenCalled()
