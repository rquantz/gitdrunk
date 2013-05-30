describe "AddIngredients", ->
  
  describe "when instantiated", ->
    add_ingredients_view = null
    ingredients = null

    beforeEach ->
      ingredients = new App.Collections.Ingredients([
        {amount: '1 oz', spirit_name: 'Gin', spirit_id: 1, recipe_id: 3},
        {amount: '1 oz', spirit_name: 'Vermouth', spirit_id: 2, recipe_id: 3}
      ])
      add_ingredients_view = new App.Views.AddIngredients({collection: ingredients, recipe_id: 3})
    
    it 'has an element', ->
      expect(add_ingredients_view.$el).toBe('.ingredients.add_ingredients')
    
    it 'has an add ingredient form', ->
      expect(add_ingredients_view.$el).toContain('form.add_ingredient_form')

    it 'has an ingredient search field', ->
      expect(add_ingredients_view.$el).toContain('.spirit_search_field')
      
    it 'has an ingredient amount field', ->
      expect(add_ingredients_view.$el).toContain('.ingredient_amount_field')

    it 'has a spirit_id field', ->
      expect(add_ingredients_view.$el).toContain('.ingredient_spirit_id_field')
    
    it 'generates a list of ingredients', ->
      expect(add_ingredients_view.$('ul .ingredient').length).toBe(2)

    describe 'set_spirit_id', ->
      it 'sets the ingredient_spirit_id_field value', ->
        add_ingredients_view.set_spirit_id(8)
        expect(add_ingredients_view.$('.ingredient_spirit_id_field').val()).toBe('8')

    describe 'recipe_id', ->
      it 'returns the recipe_id that was passed on instantiation', ->
        expect(add_ingredients_view.recipe_id()).toBe(3)
        
    describe 'clear_form', ->
      it 'clears the values from the add ingredient form', ->
        add_ingredients_view.$('.spirit_search_field').val('Orange Bitters')
        add_ingredients_view.clear_form()
        expect(add_ingredients_view.$('.spirit_search_field').val()).toBeFalsy()


    describe 'add', ->
      ingredient_attributes = null

      beforeEach ->
        ingredient_attributes = 
          spirit_name: 'Orange Bitters'
          amount: '1 oz'
          spirit_id: '4'
        add_ingredients_view.$('.spirit_search_field').val(ingredient_attributes.spirit_name)
        add_ingredients_view.$('.ingredient_amount_field').val(ingredient_attributes.amount)
        add_ingredients_view.set_spirit_id(ingredient_attributes.spirit_id)

      it 'adds a new ingredient that matches the name entered', ->
        add_ingredients_view.add()
        expect(add_ingredients_view.$('ul .ingredient').length).toBe(3)
        expect(add_ingredients_view.collection.pluck("spirit_name")).toContain(ingredient_attributes.spirit_name)
        
      it 'sets the new ingredient recipe_id to the parent recipe', ->
        add_ingredients_view.add()
        expect(add_ingredients_view.collection.last().get('recipe_id')).toBe(3)
        
      it 'clears the add ingredient form', ->
        spyOn(add_ingredients_view, 'clear_form')
        add_ingredients_view.add()
        expect(add_ingredients_view.clear_form).toHaveBeenCalled()
      
      it 'saves the ingredient', ->
        jasmine.Ajax.useMock()

        add_ingredients_view.add()
        request = mostRecentAjaxRequest()
        request.response(AjaxResponses.create_ingredient.success(ingredient_attributes))
        new_ingredient = add_ingredients_view.collection.findWhere(spirit_name: 'Orange Bitters')

        expect(new_ingredient.isNew()).toBeFalsy()
        
    describe 'form submit', ->
      it 'calls #add', ->
        spyOn(add_ingredients_view, 'add')
        add_ingredients_view.$('.add_ingredient_form').trigger('submit')
        expect(add_ingredients_view.add).toHaveBeenCalled()


