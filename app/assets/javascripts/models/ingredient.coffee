(($, Backbone, exports) ->
  
  App.Models.Ingredient = Backbone.Model.extend(
    urlRoot: '/ingredients'
  )

)(jQuery, Backbone, window)
