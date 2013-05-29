(($, Backbone, exports) ->

  App.Views.EditRecipe = Backbone.View.extend(
    initialize: ->
      @render()
    className: 'recipe edit_recipe'
    template: JST['recipes/edit_recipe']
    render: ->
      @$el.html @template(@model.attributes)
      ingredients = new App.Collections.Ingredients(@model.get('ingredients'))
      @ingredients_list = new App.Views.AddIngredients(collection: ingredients, recipe_id: @model.id)
      @$('.ingredients_list').html(@ingredients_list.$el)
    save: ->
      @model.save @form_values()
    form_values: ->
      FormHelpers.objectize @$('.edit_recipe_form')
  )

)(jQuery, Backbone, window)
