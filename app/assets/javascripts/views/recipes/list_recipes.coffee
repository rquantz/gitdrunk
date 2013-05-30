(($, Backbone, exports) ->
  
  App.Views.ListRecipes = Backbone.View.extend(
    initialize: ->
      @render()
      @collection.on('add', => @render())
      @collection.on('remove', => @render())
    className: 'recipes list_recipes'
    template: JST['recipes/list_recipes']
    render: ->
      @$el.html(@template())
      @collection.each (recipe) =>
        new App.Views.ShowRecipe(model: recipe).$el.appendTo(@$('.show_recipes_container'))
    new_recipe: ->
      @collection.add(new App.Models.Recipe(cocktail_id: @options.cocktail_id))
    events:
      'click .new_recipe_link': 'new_recipe_click'
    new_recipe_click: ->
      @new_recipe()
      return false
  )

)(jQuery, Backbone, window)
