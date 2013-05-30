(($, Backbone, exports) ->
  
  App.Views.ShowRecipe = Backbone.View.extend(
    initialize: ->
      @render()
      @model.on('change', => @render())
      if @model.isNew()
        @model.save().done => @edit()
    className: 'recipe show_recipe'
    template: JST['recipes/show_recipe']
    render: ->
      @$el.html(@template(@model.attributes))
    edit: ->
      edit_recipe_view = new App.Views.EditRecipe(model: @model).modal?()
    delete: ->
      @remove()
      @model.destroy()
    events:
      'click .edit_recipe_btn': 'edit_recipe'
      'click .delete_recipe_btn': 'delete_recipe'
    edit_recipe: ->
      @edit()
      return false
    delete_recipe: ->
      @delete()
      return false

  )

)(jQuery, Backbone, window)
