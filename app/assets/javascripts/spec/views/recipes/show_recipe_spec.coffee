describe 'ShowRecipe', ->

  describe 'when instantiated', ->
    show_recipe_view = null
    recipe = null

    beforeEach ->
      recipe = build_recipe()
      show_recipe_view = new App.Views.ShowRecipe(model: recipe)
      
    it 'has an element', ->
      expect(show_recipe_view.$el).toBe('.recipe.show_recipe')

    it 'has a list of ingredients', ->
      expect(show_recipe_view.$('.show_ingredient').length).toBe(1)

    it 're-renders when the model changes', ->
      spyOn(show_recipe_view, 'render')
      recipe.set('spirit_name', 'New name')
      expect(show_recipe_view.render).toHaveBeenCalled()
      
    describe 'edit', ->
      it 'instantiates a new EditRecipe view', ->
        spyOn(App.Views, 'EditRecipe')
        show_recipe_view.edit()
        expect(App.Views.EditRecipe).toHaveBeenCalledWith(model: recipe)
        
      it 'is called when the edit button is clicked', ->
        spyOn(show_recipe_view, 'edit')
        show_recipe_view.$('.edit_recipe_btn').trigger('click')
        expect(show_recipe_view.edit).toHaveBeenCalled()
      
    describe 'delete', ->
      it 'deletes the model', ->
        spyOn(show_recipe_view, 'remove')
        show_recipe_view.delete()
        expect(show_recipe_view.remove).toHaveBeenCalled()
        
      it 'removes the view from the DOM', ->
        spyOn(show_recipe_view.model, 'destroy')
        show_recipe_view.delete()
        expect(show_recipe_view.model.destroy).toHaveBeenCalled()
        
      it 'is called when delete_recipe_btn is clicked', ->
        spyOn(show_recipe_view, 'delete')
        show_recipe_view.$('.delete_recipe_btn').trigger('click')
        expect(show_recipe_view.delete).toHaveBeenCalled()
      
  describe 'when the modal is unsaved', ->
    new_show_recipe_view = null
    recipe = null
    
    beforeEach ->
      jasmine.Ajax.useMock()
      recipe = new App.Models.Recipe(cocktail_id: 1)
      spyOn(App.Views, 'EditRecipe')
      new_show_recipe_view = new App.Views.ShowRecipe(model: recipe)
      request = mostRecentAjaxRequest()
      request.response(AjaxResponses.save_recipe.success)
      
    it 'saves the recipe', ->
      expect(recipe.isNew()).toBeFalsy()

    it 'calls #edit', ->
      expect(App.Views.EditRecipe).toHaveBeenCalled()
