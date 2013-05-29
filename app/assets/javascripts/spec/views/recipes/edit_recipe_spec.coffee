describe "EditRecipe", ->
  
  describe "when instantiated", ->
    edit_recipe_view = null
    recipe = null
    
    beforeEach ->
      recipe = build_recipe();
      edit_recipe_view = new App.Views.EditRecipe({model: recipe});

    it 'has an element', ->
      expect(edit_recipe_view.$el).toBe('.recipe')
      expect(edit_recipe_view.$el).toBe('.edit_recipe')
    
    it 'has a form with elements', ->
      expect(edit_recipe_view.$el).toContain('form')
      expect(edit_recipe_view.$el).toContain('.tasting_notes_field')

    it 'stores the model attributes in the form', ->
      expect(edit_recipe_view.$('.tasting_notes_field').val()).toEqual(recipe.get("tasting_notes"))

    describe "ingredients_list", ->
      it 'has the recipe id of the recipe', ->
        expect(edit_recipe_view.ingredients_list.recipe_id()).toEqual(recipe.id)
      it 'has is inserted into @el', ->
        expect(edit_recipe_view.$('.ingredient').length).toEqual(recipe.get('ingredients').length)

    describe "form_values", ->
      it "returns an object with the values in the form", ->
        edit_recipe_view.$('.tasting_notes_field').val('Disgusting')
        expect(edit_recipe_view.form_values()['tasting_notes']).toEqual('Disgusting')

    describe "save", ->
      it "saves the model with the values in the form", ->
        spyOn(recipe, 'save')
        edit_recipe_view.save()
        expect(recipe.save).toHaveBeenCalledWith(edit_recipe_view.form_values())
