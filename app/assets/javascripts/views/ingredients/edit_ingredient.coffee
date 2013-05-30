(($, Backbone, exports) ->
  
  App.Views.EditIngredient = Backbone.View.extend(
    initialize: ->
      @render()
    tagName: 'li'
    className: 'ingredient edit_ingredient'
    template: JST['ingredients/edit_ingredient']
    render: ->
      @$el.html @template(@model.attributes)
    delete: ->
      @remove()
      @model.destroy()
    events:
      'click .delete_ingredient_btn': 'delete_ingredient'
    delete_ingredient: ->
      @delete()
      false
  )

)(jQuery, Backbone, window)
