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

    it 'adds the model.cid to the element data', ->
      expect(edit_ingredient_view.$el.data('cid')).toEqual(ingredient.cid)
      
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
        
      it 'triggers a "delete" event', ->
        triggered = false
        edit_ingredient_view.on 'delete', ->
          triggered = true
        edit_ingredient_view.delete()
        expect(triggered).toBeTruthy()
        
      it 'passed itself to the "delete" event callback', ->
        callback_arg = null
        edit_ingredient_view.on 'delete', (arg) ->
          callback_arg = arg
        edit_ingredient_view.delete()
        expect(callback_arg).toBe(edit_ingredient_view)

        
