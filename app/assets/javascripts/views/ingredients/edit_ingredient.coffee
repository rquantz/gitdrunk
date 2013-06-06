(($, Backbone, exports) ->
  
  App.Views.EditIngredient = Backbone.View.extend(
    initialize: ->
      @render()
    tagName: 'tr'
    className: 'ingredient edit_ingredient'
    template: JST['ingredients/edit_ingredient']
    render: ->
      @$el.html @template(@model.attributes)
      @$el.data('cid', @model.cid)
    delete: ->
      @remove()
      @model.destroy()
      @trigger('delete', this)
    events:
      'click .delete_ingredient_btn': 'delete_ingredient'
    delete_ingredient: ->
      @delete()
      false
  )

)(jQuery, Backbone, window)
