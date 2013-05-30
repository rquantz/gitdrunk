describe 'ListRecipes', ->
  
  describe 'when instantiated', ->
    list_recipes_view = null
    recipes = null

    beforeEach ->
      recipes = build_recipes()
      list_recipes_view = new App.Views.ListRecipes(collection: recipes)

    it 'has an element', ->
      expect(list_recipes_view.$el).toBe('.recipes.list_recipes')
      
    it 'has a list of recipes', ->
      expect(list_recipes_view.$('.show_recipe').length).toBe(5)

    describe 'new_recipe', ->
      it 'adds a new recipe to the collection', ->
        list_recipes_view.new_recipe()
        expect(list_recipes_view.collection.length).toBe(6)
        
      it 'is called when add recipe link is clicked', ->
        spyOn(list_recipes_view, 'new_recipe')
        list_recipes_view.$('.new_recipe_link').trigger('click')
        expect(list_recipes_view.new_recipe).toHaveBeenCalled()
