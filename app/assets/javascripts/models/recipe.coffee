(($, Backbone, exports) ->
  
  App.Models.Recipe = Backbone.Model.extend(
    initialize: ->
      @ingredients = new App.Collections.Ingredients(@get("ingredients"))
    urlRoot: '/recipes'
    ingredients: {}
  )

)(jQuery, Backbone, window)
