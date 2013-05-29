(($, Backbone, exports) ->
  
  App.Views.EditIngredient = Backbone.View.extend(
    initialize: ->
      @render()
    tagName: 'li'
    className: 'ingredient edit_ingredient'
    template: JST['ingredients/edit_ingredient']
    render: ->
      @$el.html @template(@model.attributes)
  )

)(jQuery, Backbone, window)
