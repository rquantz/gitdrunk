(($, Backbone, exports) ->
  
  App.Models.Recipe = Backbone.Model.extend(
    initialize: ->
      @ingredients = new App.Collections.Ingredients(@get("ingredients"))
      @ingredients.on('add', @add_ingredient, this)
      @ingredients.on('remove', @remove_ingredient, this)
    urlRoot: '/recipes'
    ingredients: {}
    add_ingredient: (ingredient) ->
      @attributes.ingredients.push(ingredient.attributes)
    remove_ingredient: (i, ingredients) ->
      @set 'ingredients', ingredients.toJSON()
  )

)(jQuery, Backbone, window)

