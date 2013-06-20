(($, Backbone, exports) ->
  
  App.Models.Ingredient = Backbone.Model.extend(
    urlRoot: '/ingredients'
    validate: (attr, options) ->
      err = []
      err.push 'Please select a spirit from the dropdown' unless attr.spirit_id
      err.push 'Spirit name is required' unless attr.spirit_name
      err.push 'Ingredient amount is required' unless attr.amount
      err.push 'The ingredient must be attached to a recipe' unless attr.recipe_id
      err if err.length > 0
  )

)(jQuery, Backbone, window)
