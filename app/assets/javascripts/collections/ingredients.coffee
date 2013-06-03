(($, Backbone, exports) ->
  
  App.Collections.Ingredients = Backbone.Collection.extend(
    model: App.Models.Ingredient
    comparator: (ingredient) ->
      ingredient.get('recipe_order')
    set_recipe_order: (order) ->
      @each (i) ->
        i.set('recipe_order', order[i.cid])
      @sort()
  )

)(jQuery, Backbone, window)
