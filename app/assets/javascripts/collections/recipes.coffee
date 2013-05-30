(($, Backbone, exports) ->
  
  App.Collections.Recipes = Backbone.Collection.extend(
    model: App.Models.Recipe
  )

)(jQuery, Backbone, window)
