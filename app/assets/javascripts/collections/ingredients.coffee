(($, Backbone, exports) ->
  
  App.Collections.Ingredients = Backbone.Collection.extend(
    model: App.Models.Ingredient
  );

)(jQuery, Backbone, window)
